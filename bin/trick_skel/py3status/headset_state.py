import subprocess

class Py3status:

    def headset_state(self):
        mic = subprocess.run("pacmd list-sources 1 | grep 'active port' | cut -d- -f3- | cut -d\> -f1", shell=True, capture_output=True, encoding='latin-1')
        return {
            'full_text': mic.stdout.strip(),
            'cached_until': self.py3.time_in(1)
        }
