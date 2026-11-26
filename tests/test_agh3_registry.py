"""Offline rendering checks. These never contact Kubernetes or registry endpoints."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
CHART = ROOT / "charts/agh3"
HELM = os.environ.get("HELM_BIN", "helm")
OWNED = ("ctr-actionloop", "ctr-captain", "ctr-captain-migration", "ctr-controller", "ctr-ui", "report", "postfix", "opendkim")


def render(*extra):
    with tempfile.TemporaryDirectory() as temp:
        env = {**os.environ, "HELM_CONFIG_HOME": temp + "/config", "HELM_CACHE_HOME": temp + "/cache", "HELM_DATA_HOME": temp + "/data"}
        args = [HELM, "template", "offline", str(CHART), "--namespace", "offline-test",
                "--set-string", "keygen.apiToken=offline-fixture-not-a-real-token",
                "--set-string", "keygen.accountID=offline-fixture-not-a-real-account",
                "--set-string", "minio.auth.rootPassword=offline-fixture-not-a-real-password",
                "--set-string", "rabbitmq.auth.erlangCookie=offline-fixture-not-a-real-cookie",
                "--set", "customRegistrySecret.enabled=false", *extra]
        result = subprocess.run(args, env=env, capture_output=True, text=True, timeout=180)
        if result.returncode:
            raise AssertionError(result.stderr)
        converted = subprocess.run(["yq", "-o=json", "-I=0", "."], input=result.stdout, capture_output=True, text=True, timeout=20)
        if converted.returncode:
            raise AssertionError(converted.stderr)
        return [json.loads(line) for line in converted.stdout.splitlines() if line.strip()]


def images(documents):
    found = []
    def walk(obj):
        if isinstance(obj, dict):
            if isinstance(obj.get("image"), str):
                found.append(obj["image"])
            for value in obj.values(): walk(value)
        elif isinstance(obj, list):
            for value in obj: walk(value)
    for doc in documents: walk(doc)
    return found


class RegistryRendering(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.legacy = render()
        cls.ghcr = render("-f", str(CHART / "values-ghcr.yaml"))
        cls.upgrade = render("-f", str(CHART / "values-ghcr.yaml"), "--is-upgrade",
                             "--set-string", "captain.image.digest=sha256:" + "a" * 64)

    def test_legacy_owned_images_keep_harbor(self):
        for name in OWNED:
            self.assertTrue(any(image.startswith("registry.lkc-lab.com/leukocyte-lab/argushack3/" + name + ":") for image in images(self.legacy)), name)

    def test_ghcr_profile_moves_only_owned_images(self):
        for name in OWNED:
            self.assertTrue(any(image.startswith("ghcr.io/leukocyte-lab/argushack3/" + name + ":") for image in images(self.ghcr)), name)
        third_party = [image for image in images(self.ghcr) if "/docker/" in image]
        self.assertTrue(third_party)
        self.assertTrue(all(image.startswith("registry.lkc-lab.com/") for image in third_party))
        self.assertFalse(any(image.startswith("ghcr.io/docker/") for image in images(self.ghcr)))

    def test_runtime_registry_and_existing_pull_secrets(self):
        deployments = [doc for doc in self.ghcr if doc and doc.get("kind") == "Deployment"]
        envs = {container["name"]: {item["name"]: item.get("value") for item in (container.get("env") or [])}
                for doc in deployments for container in doc["spec"]["template"]["spec"]["containers"]}
        self.assertEqual(envs["captain"]["IMAGE_REGISTRY_URL"], "ghcr.io")
        self.assertEqual(envs["action-loop"]["IMAGE_REGISTRY_URL"], "ghcr.io")
        self.assertEqual(envs["controller"]["REGISTRY_URL"], "ghcr.io")
        for doc in deployments:
            if doc["metadata"]["name"] in ("captain", "controller", "action-loop", "ui", "report", "postfix"):
                names = {s["name"] for s in doc["spec"]["template"]["spec"].get("imagePullSecrets", [])}
                self.assertTrue({"lkc-registry", "ghcr-pull"}.issubset(names))

    def test_upgrade_render_supports_digest_pin(self):
        expected = "ghcr.io/leukocyte-lab/argushack3/ctr-captain@sha256:" + "a" * 64
        self.assertIn(expected, images(self.upgrade))

    def test_missing_license_inputs_still_fail(self):
        result = subprocess.run([HELM, "template", "negative", str(CHART), "--set", "customRegistrySecret.enabled=false"],
                                capture_output=True, text=True, timeout=180)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("required", result.stderr)


if __name__ == "__main__":
    unittest.main()
