#!/usr/bin/env python3

from argparse import ArgumentParser
from subprocess import call
import i3ipc
import functools

print = functools.partial(print, flush=True)

# state True means DPMS should be on, and xautolock enabled
# This happens when there is no fullscreen app to inhibit
#   screen timeouts / screensavers.
# We can safely assume this is true as this is launched at i3 startup.
current_state = True

i3 = i3ipc.Connection()

parser = ArgumentParser(prog='disable-standby-fs',
                        description='''
        Disable standby (dpms) and screensaver when a window becomes fullscreen
        or exits fullscreen-mode. Requires `xorg-xset`.
        ''')

args = parser.parse_args()


def find_fullscreen(con):
    # XXX remove me when this method is available on the con in a release
    return [c for c in con.descendents() if c.type == 'con' and c.fullscreen_mode]


def set_dpms(new_state):
    if new_state == current_state:
        print("no-op: keeping existing state of {}".format(new_state))
        return
    current_state = new_state
    if new_state:
        print('setting dpms on and enabling xautolock')
        call(['xautolock', '-enable'])
        call(['xset', '+dpms'])
    else:
        print('setting dpms off and disabling xautolock')
        call(['xautolock', '-disable'])
        call(['xset', '-dpms'])


def on_fullscreen_mode(i3, e):
    set_dpms(not len(find_fullscreen(i3.get_tree())))


def on_window_close(i3, e):
    if not len(find_fullscreen(i3.get_tree())):
        set_dpms(True)


i3.on('window::fullscreen_mode', on_fullscreen_mode)
i3.on('window::close', on_window_close)

print("setup complete")

i3.main()

print("ok bye")
