#!/usr/bin/env python3

import sys
import os

import gnupg


TRUST_LEVEL_MAP = {
    'q': '???',
    'n': 'Not',
    'm': 'Marginal',
    'f': 'Full',
    'u': 'Ultimate'
}


def main():

    gpg = gnupg.GPG(gnupghome="~/.gnupg",keyring="~/.gnupg/pubring.kbx")
    gpg.encoding = 'utf-8'

    keys = gpg.list_keys()
    trust_keys = filter(lambda k: k['ownertrust'] != '-', keys)

    for key in trust_keys:
        trust_level = TRUST_LEVEL_MAP[key['ownertrust']]
        print('{}  {:<59}  {}'.format(key['keyid'], key['uids'][0], trust_level))

    return os.EX_OK


if __name__ == '__main__':

    sys.exit(main())
