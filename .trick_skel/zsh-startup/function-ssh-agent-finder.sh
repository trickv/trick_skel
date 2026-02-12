ssh-agent-finder() {
    local sock
    sock=$($HOME/bin/trick_skel/ssh-agent-finder)
    if [ $? -eq 0 ]; then
        export SSH_AUTH_SOCK="$sock"
        echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
    fi
}
