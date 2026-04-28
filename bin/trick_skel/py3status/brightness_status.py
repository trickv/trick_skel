import re
import subprocess


SYSFS_BRIGHTNESS = '/sys/class/backlight/intel_backlight/brightness'
SYSFS_MAX = '/sys/class/backlight/intel_backlight/max_brightness'
OUTPUT = 'eDP-1'

_OUTPUT_LINE = re.compile(r'^[A-Za-z0-9-]+ (connected|disconnected)\b')
_BRIGHTNESS_LINE = re.compile(r'^\s*Brightness:\s*([0-9.]+)')


def _read_sysfs():
    try:
        with open(SYSFS_BRIGHTNESS) as f:
            cur = int(f.read().strip())
        with open(SYSFS_MAX) as f:
            mx = int(f.read().strip())
        return cur, mx
    except (OSError, ValueError):
        return None, None


def _read_xrandr_brightness():
    try:
        out = subprocess.run(
            ['xrandr', '--verbose'],
            capture_output=True, text=True, timeout=2,
        ).stdout
    except (subprocess.SubprocessError, FileNotFoundError):
        return 1.0

    in_block = False
    for line in out.splitlines():
        if line.startswith(OUTPUT + ' connected'):
            in_block = True
            continue
        if in_block and _OUTPUT_LINE.match(line):
            in_block = False
            continue
        if in_block:
            m = _BRIGHTNESS_LINE.match(line)
            if m:
                try:
                    return float(m.group(1))
                except ValueError:
                    return 1.0
    return 1.0


class Py3status:
    cache_timeout = 5

    def brightness_status(self):
        cur, mx = _read_sysfs()
        xrandr_b = _read_xrandr_brightness()

        if cur is None:
            return {
                'full_text': '',
                'cached_until': self.py3.time_in(self.cache_timeout),
            }

        sysfs_pct = round(100 * cur / mx) if mx else 0

        if xrandr_b < 0.999:
            message = '☀ {}% x{:.1f}'.format(sysfs_pct, xrandr_b)
            color = '#ff9900'
        else:
            message = '☀ {}%'.format(sysfs_pct)
            color = '#ffffff'

        return {
            'full_text': message,
            'color': color,
            'cached_until': self.py3.time_in(self.cache_timeout),
        }


if __name__ == '__main__':
    from py3status.module_test import module_test
    module_test(Py3status)
