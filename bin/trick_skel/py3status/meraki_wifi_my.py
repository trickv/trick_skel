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
        timeout = 60
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
            timeout = 1
        else:
            is_on_home_wifi_cmd = "nmcli d show wlp0s20f3 | grep GENERAL.CONNECTION | grep rumbledethumps"
            p = subprocess.run(is_on_home_wifi_cmd, shell=True, cwd=pathlib.Path.home(), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            if p.returncode == 0:
                ap_mac_cmd = 'iwconfig wlp0s20f3 | grep "Access Point" | cut -d: -f4-'
                p = subprocess.run(ap_mac_cmd, cwd=pathlib.Path.home(), capture_output=True, shell=True)
                ap_mac = p.stdout.decode("latin9").strip()
                ap_mac_map = {
                    'FC:EC:DA:B8:5A:C3': 'Office',
                    '74:AC:B9:28:E5:EE': 'Attic',
                    'FC:EC:DA:B7:5A:C3': 'Office 2.4ghz',
                }
                if ap_mac in ap_mac_map:
                    message = ap_mac_map[ap_mac]
                else:
                    message = "{}".format(ap_mac)
                color = "#0000ff"
                timeout = 1
            else:
                message = "(other network)"
                color = "#666666"
        return {
            'full_text': message,
            'color': color,
            'cached_until': self.py3.time_in(timeout)
        }
            


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)
