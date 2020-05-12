from subprocess import Popen, PIPE
import psutil
from threading import Thread


class Py3status:
    """
    inspired a bit by https://github.com/firecat53/py-multistatus/blob/master/plugins/watson.py
    """
    def watson(self):
        res = Popen(["watson", "status"], stdout=PIPE).communicate()[0]
        res = res.decode()
        if not res.startswith("No project started"):
            out = res.split()[1].strip()
        else:
            out = "No project"
        return {
            'full_text': out,
            'cached_until': self.py3.time_in(30),
        }
