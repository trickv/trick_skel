if [ -e /usr/local/go ]; then
    export PATH=$PATH:/usr/local/go/bin
fi
if [ -e $HOME/go ]; then
    export PATH=$PATH:$HOME/go/bin
fi
