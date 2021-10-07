import json
import http.client

class Py3status:

    def solar_status(self):
        color = "#ffff00"
        conn = http.client.HTTPSConnection("vanstaveren.us")
        conn.request("GET", "/~trick/epaper/now-ac-power.cgi")
        response = conn.getresponse().read()
        conn.close()
        now = json.loads(response)
        solar_now_value = "{0:.2f} kW".format(float(now['data']['result'][0]['value'][1]) / 1000)

        message = "Solar: {}".format(solar_now_value)
        return {
            'full_text': message,
            'color': color,
            'cached_until': self.py3.time_in(120)
        }
