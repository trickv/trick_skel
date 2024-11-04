import subprocess
import pathlib
import shlex
import sys

class Py3status:

    def meraki_wifi_my(self):
        #cmd = "curl -s http://my.meraki.com/index.json | jq -r \".config.node_name, .client.rssi\""
        #cmd = "curl -s http://my.meraki.com/index.json | jq -r '.config.node_name'"
        is_on_mintel_wifi_cmd = "nmcli d show wlp0s20f3 | grep GENERAL.CONNECTION | grep Mintel_Chicago_wifi"
        p = subprocess.run(is_on_mintel_wifi_cmd, shell=True, cwd=pathlib.Path.home(), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        if p.returncode == 0:
            cmd = "curl -s http://my.meraki.com/index.json | jq -r '.config.node_name + \" \" + .client.rssi + \"dB\"'"
            #cmd = "echo hi"
            #print(cmd, file=sys.stderr)
            p = subprocess.run(cmd, cwd=pathlib.Path.home(), capture_output=True, shell=True)
            #print(dir(p))
            status = p.stdout.decode("latin9").strip()
            #status = "foo"
            message = "{}".format(status)
            #message = "foo"
            #print(message)
            color = "#00ff00"
        else:
            message = "(not meraki)"
            color = "#666666"
        return {
            'full_text': message,
            'color': color,
            'cached_until': self.py3.time_in(1)
        }
            


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)
