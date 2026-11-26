"""Execute the workflow's packaging shell with synthetic charts and fake Helm only."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]


def packaging_script():
    lines = (ROOT / '.github/workflows/agh3-oci-candidate.yml').read_text().splitlines()
    start = lines.index('      - name: Package unique prerelease from a temporary source copy')
    start = next(i for i in range(start, len(lines)) if lines[i] == '        run: |') + 1
    body = []
    for line in lines[start:]:
        if line and not line.startswith('          '):
            break
        body.append(line[10:])
    return '\n'.join(body)


class DependencyOrder(unittest.TestCase):
    def invoke(self, omit_child=False):
        with tempfile.TemporaryDirectory() as directory:
            folder = Path(directory)
            for name in ['postfix', 'agh3']:
                chart = folder / 'charts' / name
                chart.mkdir(parents=True)
                (chart / 'Chart.yaml').write_text('apiVersion: v2\nname: ' + name + '\nversion: 0.1.0\n')
                (chart / 'Chart.lock').write_text('synthetic-locked-dependencies\n')
                self.assertFalse((chart / 'charts').exists())
            script_dir = folder / '.github/scripts'
            script_dir.mkdir(parents=True)
            shutil.copy(ROOT / '.github/scripts/chart_candidate_guard.py', script_dir)
            tools = folder / 'fake-tools'
            tools.mkdir()
            helm = tools / 'helm'
            helm.write_text('''#!/usr/bin/env python3
import os,pathlib,sys
args=sys.argv[1:]
with open(os.environ['HELM_ORDER_LOG'],'a') as log: log.write(' '.join(args)+'\\n')
if args[:2] == ['dependency','build']:
    chart=pathlib.Path(args[2])
    if chart.name == 'agh3' and not (chart.parent/'postfix/charts/common.fixture').is_file(): sys.exit(19)
    (chart/'charts').mkdir(exist_ok=True)
    (chart/'charts'/('common.fixture' if chart.name=='postfix' else 'postfix.fixture')).write_text('synthetic')
elif args[0] == 'lint':
    assert (pathlib.Path(args[1])/'charts/postfix.fixture').is_file()
elif args[0] == 'package':
    out=pathlib.Path(args[args.index('--destination')+1])
    (out/os.environ['CANDIDATE_FILENAME']).write_bytes(b'synthetic-chart-archive')
elif args[:2] == ['show','chart']:
    print('name: agh3\\nversion: '+os.environ['CANDIDATE_VERSION'])
''')
            helm.chmod(0o755)
            version = '0.0.0-candidate.sha' + 'a' * 40 + '.run42.attempt1'
            log = folder / 'helm.log'
            env = {**os.environ, 'PATH': str(tools) + os.pathsep + os.environ['PATH'],
                   'RUNNER_TEMP': str(folder / 'runner'), 'HELM_ORDER_LOG': str(log),
                   'CANDIDATE_VERSION': version, 'CANDIDATE_FILENAME': 'agh3-' + version + '.tgz'}
            script = packaging_script()
            if omit_child:
                script = script.replace('helm dependency build "$staging/charts/postfix"', '')
            result = subprocess.run(['bash', '-euo', 'pipefail', '-c', script], cwd=folder, env=env, capture_output=True, text=True)
            calls = log.read_text().splitlines()
            for name in ['postfix', 'agh3']:
                self.assertEqual('synthetic-locked-dependencies\n', (folder / 'charts' / name / 'Chart.lock').read_text())
            return result, calls

    def test_empty_dependency_directories_build_child_before_parent(self):
        result, calls = self.invoke()
        self.assertEqual(0, result.returncode, result.stderr)
        builds = [line for line in calls if line.startswith('dependency build ')]
        self.assertEqual(2, len(builds))
        self.assertTrue(builds[0].endswith('/charts/postfix'))
        self.assertTrue(builds[1].endswith('/charts/agh3'))

    def test_omitting_child_build_is_detected_before_packaging(self):
        result, calls = self.invoke(omit_child=True)
        self.assertEqual(19, result.returncode)
        self.assertFalse(any(line.startswith('package ') for line in calls))


if __name__ == '__main__':
    unittest.main()
