import subprocess
import pathlib
import shlex

class Py3status:

    def gpg_status(self):
        color = "#ffff00"
        status = ""
        cmd = "gpg --pinentry-mode cancel --batch --no-tty -n -d .gnupg/{}-opengpg.gpg"
        cmd = "gpg --pinentry-mode cancel --batch --no-tty -n -d .gnupg/{}.gpg"

        #cards = subprocess.check_output(shlex.split("ssh-add -l"), shell=True).decode("utf-8").split("\n")
        cards = "2048 SHA256:IQo2sG9RcyKhRW+8uR4OoUDMk3S9lU55UPkzVAhlQCg cardno:000605672437 (RSA)\n4096 SHA256:/A9g24J/P5zek3lLu0Yn5aIIDflAl9zem0UajHHjvWc cardno:000605661937 (RSA)\n2048 SHA256:QHpeOwloedlRczsnLhtpxMkBXTGGb2bSiHTmIH+zePc cardno:000609625189 (RSA)\n".split("\n")
        for card in cards:
            if card == "":
                continue
            #print(card)
            card = card.split(" ")[2]
            #print(card)
            p = subprocess.run(shlex.split(cmd.format(card)), cwd=pathlib.Path.home(), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            cardmap = {
                'cardno:000605672437': '🟩',
                'cardno:000605661937': '🟦',
                'cardno:000609625189': '🟧',
            }
            codemap = {
                2: '🔴',
                1: '1',
                0: '🟢',
            }
            status += " {}{}".format(cardmap[card], codemap[p.returncode])
            

        message = "GPG{}".format(status)
        return {
            'full_text': message,
            'color': color,
            'cached_until': self.py3.time_in(3600)
        }

if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)
