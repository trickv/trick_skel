import pulsectl

class Py3status:
    pulse = pulsectl.Pulse('headsetstate')

    def headset_state2(self):
        sources = self.pulse.source_list()
        builtin_source = None
        for source in sources:
            if source.description == "Built-in Audio Analog Stereo":
                builtin_source = source
        if not builtin_source:
            return {'full_text': "bug: built-in card not found"}
        active = builtin_source.port_active
        if not active:
            port = "bug: not active?"
        else:
            port = active.name.replace("analog-input-", "")
        card = builtin_source.description.split(' ')[0]
        message = "{}: {}".format(card, port)
        return {
            'full_text': message,
            'cached_until': self.py3.time_in(1)
        }
