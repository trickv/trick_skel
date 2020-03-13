import pulsectl

class Py3status:
    pulse = pulsectl.Pulse('headsetstate')

    def headset_state2(self):
        sources = self.pulse.source_list()
        sinks = self.pulse.sink_list()
        builtin_source = None
        builtin_sink = None
        for source in sources:
            if source.description == "Built-in Audio Analog Stereo":
                builtin_source = source
        for sink in sinks:
            if sink.description == "Built-in Audio Analog Stereo":
                builtin_sink = sink
        if not builtin_source or not builtin_sink:
            return {'full_text': "bug: built-in card not found"}
        source_index = builtin_source.index
        sink_index = builtin_sink.index
        active = builtin_source.port_active
        if not active:
            port = "bug: not active?"
        else:
            port = active.name.replace("analog-input-", "")
        card = builtin_source.description.split(' ')[0]
        message = "{}: {}, idx={}, sink idx={}".format(card, port, source_index, sink_index)
        return {
            'full_text': message,
            'cached_until': self.py3.time_in(1)
        }
