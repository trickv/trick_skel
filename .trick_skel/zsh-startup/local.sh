if [ -e $HOME/.local/bin/env ]; then
    . "$HOME/.local/bin/env"
fi

if [ -e $HOME/.local/bin ]; then
    export PATH=$HOME/.local/bin:$PATH
fi
