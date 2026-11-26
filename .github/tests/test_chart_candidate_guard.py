import importlib.util
import contextlib
import io
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest import mock

ROOT = Path(__file__).resolve().parents[2]
SPEC = importlib.util.spec_from_file_location('chart_guard', ROOT / '.github/scripts/chart_candidate_guard.py')
guard = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(guard)


def valid():
    return dict(GITHUB_REPOSITORY='Leukocyte-Lab/helm-charts', GITHUB_EVENT_NAME='workflow_dispatch',
                GITHUB_REF_PROTECTED='true', GITHUB_REF='refs/heads/main', PUBLISH_CANDIDATE='true',
                GHCR_CHART_CANDIDATE_ENABLED='true', GHCR_CHART_WRITER_EXCLUSION_VERIFIED='true',
                GHCR_CHART_COST_APPROVED='true', GITHUB_SHA='a' * 40, EXPECTED_SOURCE_SHA='a' * 40,
                GITHUB_RUN_ID='42', GITHUB_RUN_ATTEMPT='1')


def metadata():
    return dict(name='charts/agh3', package_type='container', visibility='private',
                owner={'login': 'Leukocyte-Lab'}, repository={'full_name': 'Leukocyte-Lab/helm-charts'})


class ChartCandidate(unittest.TestCase):
    def test_pr_push_unprotected_or_any_closed_gate_is_rejected(self):
        for key, value in [('GITHUB_EVENT_NAME', 'pull_request'), ('GITHUB_EVENT_NAME', 'push'),
                           ('GITHUB_REF_PROTECTED', 'false'), ('GITHUB_REF', 'refs/heads/codex/test'),
                           ('GITHUB_REPOSITORY', 'other/fork'), ('EXPECTED_SOURCE_SHA', 'b' * 40),
                           ('PUBLISH_CANDIDATE', 'false'), ('GHCR_CHART_CANDIDATE_ENABLED', 'false'),
                           ('GHCR_CHART_WRITER_EXCLUSION_VERIFIED', 'false'), ('GHCR_CHART_COST_APPROVED', 'false')]:
            with self.subTest(key=key, value=value), self.assertRaises(ValueError):
                guard.prepare({**valid(), key: value})

    def test_candidate_semver_is_unique_and_never_formal(self):
        version = guard.prepare(valid())['version']
        self.assertRegex(version, r'^0\.0\.0-candidate\.sha[a-f0-9]{40}\.run42\.attempt1$')
        self.assertNotEqual('3.15.0', version)
        for key, value in [('GITHUB_RUN_ID', '43'), ('GITHUB_RUN_ATTEMPT', '2')]:
            self.assertNotEqual(version, guard.prepare({**valid(), key: value})['version'])
        for key, value in [('GITHUB_SHA', 'bad'), ('GITHUB_RUN_ID', '0'), ('GITHUB_RUN_ATTEMPT', '1\nother=value')]:
            with self.assertRaises(ValueError):
                guard.prepare({**valid(), key: value})

    def test_name_owner_private_link_and_type_must_match(self):
        guard.verify_metadata(metadata())
        for key, value in [('name', 'charts/other'), ('visibility', 'public'), ('visibility', 'internal'),
                           ('package_type', 'npm'), ('owner', None), ('repository', None),
                           ('owner', {'login': 'other'}), ('repository', {'full_name': 'Leukocyte-Lab/other'})]:
            with self.subTest(key=key, value=value), self.assertRaises(ValueError):
                guard.verify_metadata({**metadata(), key: value})

    def test_existing_version_or_unknown_tag_list_is_blocked(self):
        version = guard.prepare(valid())['version']
        guard.verify_unused_version([[]], version)
        guard.verify_unused_version([[{'metadata': {'container': {'tags': ['old']}}}]], version)
        for pages in [None, [], [{}], [[{}]], [[{'metadata': {'container': {'tags': [version]}}}]]]:
            with self.assertRaises(ValueError):
                guard.verify_unused_version(pages, version)

    def test_packaged_name_and_version_cannot_bypass_fixed_package(self):
        version = guard.prepare(valid())['version']
        guard.verify_chart_yaml('name: agh3\nversion: ' + version + '\n', version)
        with self.assertRaises(ValueError):
            guard.verify_chart_yaml('name: agh3\nversion: 3.15.0', '3.15.0')
        for text in ['name: other\nversion: ' + version, 'name: agh3\nversion: 3.15.0',
                     'name: agh3\nname: other\nversion: ' + version]:
            with self.assertRaises(ValueError):
                guard.verify_chart_yaml(text, version)

    def test_cli_uses_only_fake_api_and_blocks_denied_or_existing(self):
        with tempfile.TemporaryDirectory() as directory:
            folder = Path(directory)
            gh = folder / 'gh'
            gh.write_text('''#!/usr/bin/env python3
import os,sys
if os.environ.get('FIXTURE_DENIED') == 'true': sys.exit(1)
print(os.environ['FIXTURE_VERSIONS' if '/versions?' in sys.argv[-1] else 'FIXTURE_PACKAGE'])
''')
            gh.chmod(0o755)
            version = guard.prepare(valid())['version']
            for changes, success in [({}, True), ({'FIXTURE_DENIED': 'true'}, False),
                                     ({'FIXTURE_VERSIONS': json.dumps([[{'metadata': {'container': {'tags': [version]}}}]])}, False)]:
                output = folder / 'output'
                output.unlink(missing_ok=True)
                env = {**os.environ, **valid(), 'PATH': directory + os.pathsep + os.environ['PATH'],
                       'GH_TOKEN': 'synthetic-job-token', 'GITHUB_OUTPUT': str(output),
                       'FIXTURE_PACKAGE': json.dumps(metadata()), 'FIXTURE_VERSIONS': '[[]]', **changes}
                result = subprocess.run(['python3', str(ROOT / '.github/scripts/chart_candidate_guard.py')], env=env, capture_output=True, text=True)
                self.assertEqual(success, result.returncode == 0, result.stderr)
                self.assertEqual(success, output.exists())
                self.assertNotIn('synthetic-job-token', result.stdout + result.stderr)

    def test_api_timeout_is_bounded_and_fails_without_output(self):
        response = mock.Mock(returncode=0, stdout=json.dumps(metadata()))
        with mock.patch.object(guard.subprocess, 'run', return_value=response) as run:
            guard.api('/synthetic-metadata')
            self.assertEqual(60, run.call_args.kwargs['timeout'])
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / 'output'
            env = {**valid(), 'GH_TOKEN': 'synthetic-job-token', 'GITHUB_OUTPUT': str(output)}
            diagnostic = io.StringIO()
            with mock.patch.dict(os.environ, env, clear=True), \
                    mock.patch.object(guard.subprocess, 'run', side_effect=subprocess.TimeoutExpired('gh', 60)), \
                    contextlib.redirect_stderr(diagnostic):
                self.assertEqual(1, guard.main())
            self.assertFalse(output.exists())
            self.assertNotIn('synthetic-job-token', diagnostic.getvalue())


if __name__ == '__main__':
    unittest.main()
