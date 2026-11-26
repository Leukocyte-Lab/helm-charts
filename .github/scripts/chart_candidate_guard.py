#!/usr/bin/env python3
"""Candidate chart metadata gate. No packaging, registry login, or push here."""
import json
import os
from pathlib import Path
import re
import subprocess
import sys

PACKAGE = 'charts/agh3'
REPOSITORY = 'Leukocyte-Lab/helm-charts'


def prepare(env):
    if env.get('GITHUB_REPOSITORY', '').lower() != REPOSITORY.lower():
        raise ValueError('Unexpected repository')
    if env.get('GITHUB_EVENT_NAME') != 'workflow_dispatch':
        raise ValueError('Only explicit manual candidates are allowed')
    if env.get('GITHUB_REF_PROTECTED') != 'true' or env.get('GITHUB_REF') != 'refs/heads/main':
        raise ValueError('Protected main is required')
    for key in ['PUBLISH_CANDIDATE', 'GHCR_CHART_CANDIDATE_ENABLED',
                'GHCR_CHART_WRITER_EXCLUSION_VERIFIED', 'GHCR_CHART_COST_APPROVED']:
        if env.get(key) != 'true':
            raise ValueError('Candidate readiness gate is closed')
    sha = env.get('GITHUB_SHA', '')
    if not re.fullmatch('[0-9a-f]{40}', sha) or env.get('EXPECTED_SOURCE_SHA') != sha:
        raise ValueError('The reviewed exact source SHA is required')
    for key in ['GITHUB_RUN_ID', 'GITHUB_RUN_ATTEMPT']:
        if not re.fullmatch('[1-9][0-9]{0,19}', env.get(key, '')):
            raise ValueError('Unique run identity is required')
    version = '0.0.0-candidate.sha' + sha + '.run' + env['GITHUB_RUN_ID'] + '.attempt' + env['GITHUB_RUN_ATTEMPT']
    if len(version) > 128:
        raise ValueError('Candidate version is too long')
    return {'version': version, 'filename': 'agh3-' + version + '.tgz',
            'reference': 'oci://ghcr.io/leukocyte-lab/charts/agh3', 'source_sha': sha}


def verify_metadata(data):
    if not isinstance(data, dict) or data.get('package_type') != 'container':
        raise ValueError('Container metadata is required')
    if data.get('name') != PACKAGE or data.get('visibility') != 'private':
        raise ValueError('Exact private package is required')
    owner = data.get('owner')
    linked = data.get('repository')
    if not isinstance(owner, dict) or str(owner.get('login', '')).lower() != 'leukocyte-lab':
        raise ValueError('Owner is unverified')
    if not isinstance(linked, dict) or str(linked.get('full_name', '')).lower() != REPOSITORY.lower():
        raise ValueError('Same-repository linkage is unverified')


def verify_unused_version(pages, version):
    if not isinstance(pages, list) or not pages:
        raise ValueError('Complete version pages are required')
    for page in pages:
        if not isinstance(page, list):
            raise ValueError('Version response is unknown')
        for item in page:
            metadata = item.get('metadata') if isinstance(item, dict) else None
            container = metadata.get('container') if isinstance(metadata, dict) else None
            tags = container.get('tags') if isinstance(container, dict) else None
            if not isinstance(tags, list) or not all(isinstance(tag, str) for tag in tags):
                raise ValueError('Existing tags are unknown')
            if version in tags:
                raise ValueError('Candidate tag already exists; never overwrite')


def verify_chart_yaml(text, version):
    if not re.fullmatch(r'0\.0\.0-candidate\.sha[0-9a-f]{40}\.run[1-9][0-9]{0,19}\.attempt[1-9][0-9]{0,19}', version) or len(version) > 128:
        raise ValueError('Only unique candidate versions are allowed')
    # Helm show chart emits canonical YAML for these fixed ASCII identifiers.
    # Reject ambiguous/quoted/unknown output rather than infer another name.
    names = [line for line in text.splitlines() if line.startswith('name:')]
    versions = [line for line in text.splitlines() if line.startswith('version:')]
    if names != ['name: agh3'] or versions != ['version: ' + version]:
        raise ValueError('Packaged chart name/version differs from the preflight')


def api(endpoint, paginate=False):
    args = ['gh', 'api', '--hostname', 'github.com', '-H', 'Accept: application/vnd.github+json',
            '-H', 'X-GitHub-Api-Version: 2022-11-28']
    if paginate:
        args += ['--paginate', '--slurp']
    result = subprocess.run(args + [endpoint], capture_output=True, text=True, check=False, timeout=60)
    if result.returncode or len(result.stdout) > 1024 * 1024:
        raise ValueError('Private metadata access is unknown')
    return json.loads(result.stdout)


def main():
    try:
        candidate = prepare(os.environ)
        if not os.environ.get('GH_TOKEN'):
            raise ValueError('Job token is missing')
        endpoint = '/orgs/leukocyte-lab/packages/container/charts%2Fagh3'
        verify_metadata(api(endpoint))
        verify_unused_version(api(endpoint + '/versions?per_page=100', paginate=True), candidate['version'])
        with Path(os.environ['GITHUB_OUTPUT']).open('a') as stream:
            for key, value in candidate.items():
                stream.write(key + '=' + value + '\n')
    except (ValueError, TypeError, OSError, KeyError, subprocess.TimeoutExpired):
        print('Chart candidate blocked: source/private/link/access/version/writer/cost readiness is unverified', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    if len(sys.argv) == 3 and sys.argv[1] == 'verify-archive-metadata':
        try:
            verify_chart_yaml(sys.stdin.read(), sys.argv[2])
        except ValueError:
            print('Packaged chart identity is unverified; publication blocked', file=sys.stderr)
            raise SystemExit(1)
    else:
        raise SystemExit(main())
