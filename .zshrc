# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="tricky-fino"
# Good themes from random:
# agnoster # meh, weird symbols
# kiwi
# xiong-chiamiov-plus # meh
# fino
# wedisagree
# daveverwer
# fino-time
# jonathan
# af-magic
# jonathan # huge/heavy/cool
# linuxonly # pretty
# avit # shows git last commit time

# minimal themes:
# sorin # super minimal
# muse shows path but still minimal
# avit

# final selection is probably fino / fino-time vs jonathan

# fino:
#[oh-my-zsh] Random theme 'fino' loaded
#╭─pv at CHI-Linux-L-016 in ~ using
#╰─○

# difference between fino and fino-time is subtle

# [oh-my-zsh] Random theme 'jonathan' loaded
#┌─(~)──────────────────────────────────────(pv@CHI-Linux-L-016:pts/3)─┐
#└─(17:16:26)──>                                         ──(Mon,Jul06)─┘




# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=( "fino" "fino-time" "jonathan" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom/
# i think i need this hack which I do not understand to include my custom completions:
fpath+=$ZSH_CUSTOM/completions

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git watson hitchhiker command-time)

source $ZSH/oh-my-zsh.sh
#ZSH_CUSTOM=$HOME/.oh-my-zsh-custom/

# to use plugin svn or svn-fast-info neither of which are fast:
prompt_svn() {
    local rev branch
    if in_svn; then
        rev=$(svn_get_rev_nr)
        branch=$(svn_get_branch_name)
        if [[ $(svn_dirty_choose_pwd 1 0) -eq 1 ]]; then
            prompt_segment yellow black
            echo -n "$rev@$branch"
            echo -n "±"
        else
            prompt_segment green black
            echo -n "$rev@$branch"
        fi
    fi
}

# build_prompt() {
#    RETVAL=$?
#    prompt_status
#    prompt_context
#    prompt_dir
#    prompt_git
#    #prompt_svn
#    svn_prompt_info
#    prompt_end
#}
#



# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

PATH=$HOME/bin/trick_skel:$HOME/bin:$HOME/src/svn.mintel.ad/infra/network/bin:$PATH


# GPG / SSH handling
if [[ -z ${SSH_CLIENT+x} || -e $HOME/.ssh/jumpbox ]]; then
    if [ -e $HOME/.ssh/use-gpg ]; then
        echo "Local GPG mode: setting SSH_AUTH_SOCK to local gpg agent-ssh-socket"
        unset SSH_AGENT_PID
        if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
          export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
        fi
    else
        #echo "Using old world SSH startup for local keys"
        source $HOME/.trick_skel/sh-startup/20-ssh
        trick_skel_start_keychain
    fi
else
    if [ "$ASCIINEMA_REC" != "1" ]; then
        echo "Remote SSH session; not doing anything with SSH_AUTH_SOCK"
    fi
fi

export today=$(date +%Y-%m-%d)

### https://stackoverflow.com/a/13021677/289006
# NPM packages in homedir
NPM_PACKAGES="$HOME/.npm-packages"
# Tell our environment about user-installed node tools
PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
which manpath &> /dev/null
if [ $? -eq 0 ]; then
    unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
    MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
fi

# Tell Node about these packages
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

if [ -e $HOME/.asdf/asdf.sh ]; then
    . $HOME/.asdf/asdf.sh
fi
if [ -d "$HOME/android-platform-tools" ] ; then
    export PATH="$HOME/android-platform-tools:$PATH"
fi

set-virt () {
    export LIBVIRT_DEFAULT_URI=qemu+ssh://$(whoami)@$1/system
    echo LIBVIRT_DEFAULT_URI=$LIBVIRT_DEFAULT_URI
    virsh list --all
}

if [ "$ASCIINEMA_REC" != "1" ]; then
    hitchhiker_cow
fi

if [ -e /var/run/reboot-required ]; then
    echo -n "APT says reboot required as of "
    echo -n $((($(date +%s) - $(date +%s -r "/var/run/reboot-required")) / 3600)) hours ago
    echo -n " ("
    echo -n $((($(date +%s) - $(date +%s -r "/var/run/reboot-required")) / 1)) seconds
    echo ")"
fi

nogpg () {
    alias git='git -c commit.gpgsign=false'
    alias yadm='yadm -c commit.gpgsign=false'
    export TRICK_SKEL_NO_GPG=1
    #export TRICKY_PROMPT_SUFFIX=" >nogpg< "
}

____git() {
    args=$@
    if [[ $1 == "commit" && "$TRICK_SKEL_NO_GPG" == "1" ]]; then
        #args=("${(@)a:#commit}")
        #@[1]=()
        shift args
        echo " $0 commit --no-gpg-sign \"$args\""
        command $0 commit --no-gpg-sign $args
    else
        echo "wtf git $0 $1 \"$@\""
        command $0 "$@"
    fi
}

# mosh via shell from JuiceSSH seems to send odd Home/End keys so bind them:
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line

# gam gets installed here which is weird but ok:
if [ -e $HOME/bin/gam7/gam ]; then
    alias gam="/home/pv/bin/gam7/gam"
fi

. "$HOME/.local/bin/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# If we have a hostname specific script in ~/.${host}.sh, run it
HOSTNAME=$(hostname)
if [ -f "${HOME}/.${HOSTNAME}.sh" ]; then
    if [ "`head -n 1 ${HOME}/.${HOSTNAME}.sh`" != "# quiet!" ]; then
        echo "Executing .${HOSTNAME}.sh (add '# quiet!' to hide this)"
    fi
    . ${HOME}/.${HOSTNAME}.sh
fi

files=( /home/trick/.trick_skel/zsh-startup/*.sh )

for file in "${files[@]}"; do
  if [[ -f "$file" ]]; then
    source "$file" 2>/dev/null || echo "Error sourcing $file" >&2
  fi
done

