# Private GHCR candidate

This unpublished chart is reconstructed from current `main` (chart 3.14.15,
application v3.13.0). It carries the unpublished 3.15.0/v3.13.1 version intent of
closed, unmerged PR #471 while preserving the newer main component versions:
Captain, ActionLoop and migration v1.17.8, UI v1.15.32, Controller v1.3.2 and
Report v1.3.5. It does not downgrade main to the older PR component versions.
Tags identify the compatibility candidate; registry digest and runtime verification
remain release requirements.

These existing component tags are a compatibility baseline, not a claim that they
contain the proposed removal of the points system. The Captain, UI and Controller
source changes require separately built, reviewed versions and new verified
digests. Do not publish or use this candidate as a points-free release until that
build and end-to-end acceptance have completed.

`values-ghcr.yaml` is an explicit opt-in for organization-owned images. The default
values retain Harbor and existing offline behavior. The optional
`global.firstPartyImageRegistry` changes owned images, their runtime image registry,
and the bundled Postfix images. Third-party cached images retain the existing
`global.imageRegistry` until their authorization and destination contents have been
verified independently. `controller.env.REGISTRY_URL` is set by the GHCR profile;
any packet-streamer override must use the separately verified image reference and
a Controller version that supports that override.

Before using the profile, verify each destination manifest and platform digest,
blobs, signatures and attestations, and confirm private visibility and pull access.
Supply an existing `ghcr-pull` secret and the legacy `lkc-registry` secret in the
same namespace; the profile does not generate or alter either credential. Provide
an additional reviewed values file with the verified immutable image digests.
No destination images are claimed available by this source change.

The candidate OCI path is `oci://ghcr.io/leukocyte-lab/charts/agh3`. Publish only
after isolated install/upgrade and negative checks pass with the actual OCI chart,
runtime Pods, hooks and migration image IDs. Packaging or `helm template` alone is
not runtime acceptance. Existing public chart archives, their index and release
branches are not changed by this candidate.

All dependency archives must be bundled in the package. Postfix 0.1.5 comes from
the same repository through `file://../postfix`; the previous 0.1.4 package was
compared to that source before this change. Consumers install the complete OCI
archive without consulting the old Helm index. Locked external chart versions and
their original copyright notices are preserved; see `THIRD_PARTY_NOTICES.md`.

For a source build, configure only the Bitnami and Grafana repositories, build
`charts/postfix` dependencies first, then `charts/agh3` dependencies, and package
the chart with Helm 3.10.3. This source path does not need the old organization Helm
index. The complete packaged archive was also rendered with an empty Helm cache;
this offline check does not replace the isolated OCI install and runtime checks.

To revert the proposed registry selection, omit `values-ghcr.yaml` or clear
`global.firstPartyImageRegistry`, restore the previous Controller registry setting,
and use the previously deployed chart and values. Retain old credentials and
Harbor contents until the separate customer cutover is approved. This change does
not perform that cutover.
