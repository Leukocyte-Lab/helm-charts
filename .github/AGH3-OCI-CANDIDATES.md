# AGH3 chart CI candidate — formal 3.15.0 has not been published

This is a local CI candidate for existing Draft PR #476. It does not publish the chart or make any image/runtime acceptance claim. No workflow has been dispatched, no package or permission/linkage has been created/changed, and no branch/PR update has been sent by this work.

## Existing compatibility automation

The five AGH3/Playground legacy workflows retain their existing commands but now require the exact repository, a protected branch and `LEGACY_AGH3_CHART_AUTOMATION_ENABLED=true` before using credentials or writing anything:

- `agh3-auto-release.yaml`: AGH3 gh-pages chart/index and ArrayBAS OEM gh-pages chart/index.
- `agh3-playground-publish.yaml`: Playground gh-pages chart/index.
- `agh3-release.yml` / `agh3-playground-release.yml`: latest-source version selection and release-chart PR preparation.
- `agh3-update-develop-release-channel.yml`: cross-repository release-channel workflow dispatch.

The existing commands are compatibility code, not evidence that the old release paths were executed or approved. The new OCI candidate gate does not enable these legacy paths. No AGH2/Postfix workflow, chart source/schema/test, OEM source or deployed customer has been modified here.

## New private OCI candidate only

`agh3-oci-candidate.yml` has a read-only PR job that runs only synthetic Python guards, without credentials, Helm packaging, dependency downloads or service calls.

Publication can run only from a manual request on protected `main` with `publish_candidate=true`, the reviewed full source SHA equal to that run's SHA, and all three repository variables set to `true`: `GHCR_CHART_CANDIDATE_ENABLED`, `GHCR_CHART_WRITER_EXCLUSION_VERIFIED`, `GHCR_CHART_COST_APPROVED`. This work does not set or assume the current value of any variable.

The job must first read `charts/agh3` as an existing container package owned by Leukocyte-Lab, private, linked to `Leukocyte-Lab/helm-charts`. Missing/inaccessible/different metadata stops the job. Each metadata/version command has a 60-second timeout and fails closed on timeout. It then fully paginates active package versions and refuses an existing candidate tag or an unknown tag response. No fallback identity, package creation, relinking or visibility change is provided. Metadata reads do not prove `GITHUB_TOKEN` package write access; the actual token/access and package prerequisites remain unverified.

The only version this workflow constructs is `0.0.0-candidate.sha<full SHA>.run<run ID>.attempt<attempt>`. It never publishes `3.15.0`, latest or another release/channel alias. A single job/concurrency group and unique run/attempt namespace avoid reuse by this workflow; all other writers must be proven to exclude that namespace before the writer-readiness gate is enabled. The tag-list check is not an atomic create-if-absent operation.

Helm builds the temporary Postfix dependency first (including its locked common child), then the AGH3 parent. It does not update lock versions. Helm 3.13.3 packages that temporary copy of the existing chart/dependencies with `--version` set to the unique candidate. The original chart's 3.15.0 metadata is not rewritten or published as that version. The packaged name/version is checked again before login/push so a renamed chart cannot bypass the fixed-package preflight. No signing, provenance rewrite or old artifact retagging is performed.

The push target is `oci://ghcr.io/leukocyte-lab/charts`; Helm infers `agh3:<candidate version>` from the archive. Pull uses `oci://ghcr.io/leukocyte-lab/charts/agh3 --version <candidate>`. The workflow plans an archive readback/byte comparison, which would verify only the chart archive roundtrip, not full OCI manifest/blobs/referrers, image availability, license behavior or Kubernetes acceptance. None of those remote steps has been executed locally.

The ephemeral job token is supplied to Helm via password stdin and the standard temporary registry-config file under `RUNNER_TEMP`, with an always-cleanup step. This does not claim all CI credentials avoid files; the legacy checkout/SSH mechanisms also retain their standard temporary behavior. No local Mac credentials are read or exported by the synthetic checks.

## Formal release remains a separate stage

Publishing formal private `3.15.0` still requires new point-free Captain/ActionLoop/migration/Controller/UI images and exact digest combinations, authorized third-party sources, complete manifest/platform/blob/attachment verification, writer/cost proof, private OCI pull/install, isolated clean-cluster imageIDs/readiness/health, offline and no-point DNS/HTTP negative evidence. Existing license/pull-secret compatibility must be verified with the approved isolated environment. These prerequisites are not represented by successful lint, metadata GET, source unit tests or an archive roundtrip.

This CI has no promotion or formal-version publication job and no OCI-to-release-channel update. Keep the legacy/new gates disabled until their distinct readiness evidence is reviewed. Rollback is to keep the current verified chart/image deployment and existing access settings, revert this CI change if necessary, and leave all historical tags/artifacts and Harbor intact.

## Validation and sources

Local validation is scoped to the six changed/new workflows, synthetic gate/metadata/version/archive-identity/timeout fixtures, empty-dependency child-before-parent shell controls and command-preservation checks. It does not run Helm dependency/package/push/pull, Docker, Kubernetes, OEM publication, a release workflow or a paid service.

- [Helm OCI push/pull reference semantics](https://helm.sh/docs/topics/registries/): push omits the chart basename/tag; pull includes the chart name/version.
- [GitHub package metadata/version API](https://docs.github.com/en/rest/packages/packages?apiVersion=2022-11-28): read-access metadata is not write authorization.
