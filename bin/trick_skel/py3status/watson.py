from subprocess import Popen, PIPE
import psutil
import json
from threading import Thread


class Py3status:
    """
    inspired a bit by https://github.com/firecat53/py-multistatus/blob/master/plugins/watson.py
    """
    def watson(self):
        res = Popen(["watson", "status"], stdout=PIPE).communicate()[0]
        res = res.decode()
        if not res.startswith("No project started"):
            out = res[0:res.index("(") - 1]
            out = " ".join(out.split()[1:])
            out = out.replace(" started ", ": ")
            out = out.replace(" ago", "")
            out = out.strip()
        else:
            out = "No project"
        res = Popen("watson report --json -d".split(' '), stdout=PIPE).communicate()[0]
        doc = json.loads(res.decode())
        seconds_today = int(doc['time'])
        hours = int(seconds_today / 3600)
        minutes = int((seconds_today % 3600) / 60)
        out += " ({}h{}m)".format(hours, minutes)
        return {
            'full_text': out,
            'cached_until': self.py3.time_in(30),
        }
