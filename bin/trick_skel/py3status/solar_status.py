import json
import http.client

class Py3status:

    def solar_status(self):
        color = "#ffff00"
        try:
            conn = http.client.HTTPSConnection("vanstaveren.us")
            conn.request("GET", "/~trick/epaper/now-ac-power.cgi")
            response = conn.getresponse().read()
            conn.close()
            now = json.loads(response)
            #print(now)
            #solar_now_value = "{0:.2f} kW".format(float(now['data']['result'][0]['value'][1]) / 1000)
            solar_now_value = "{0:.2f} kW".format(float(now['state']) / 1000)

            message = "Solar: {}".format(solar_now_value)
        except Exception as e:
            #print(e)
            message = "d'oh"

        return {
            'full_text': message,
            'color': color,
            'cached_until': self.py3.time_in(120)
        }

if __name__ == "__main__":
    """
    Run module in test mode.
    """
    config = {
        'always_show': True,
    }
    from py3status.module_test import module_test
    module_test(Py3status, config=config)
