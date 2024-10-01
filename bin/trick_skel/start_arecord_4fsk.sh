#!/usr/bin/env bash

source venv/bin/activate

DECODER=./build/src/horus_demod
FSK_LOWER=1000
FSK_UPPER=11000

arecord -f S16_LE -r 48000 | \
    $DECODER  --stats=5 -g -m binary --fsk_lower=$FSK_LOWER --fsk_upper=$FSK_UPPER - - | \
    python -m horusdemodlib.uploader

# -m binary -q --stats=5 -g - - | \
