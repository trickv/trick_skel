# tricky-fino.zsh-theme
# based on oh-my-zsh theme "fino" but less annoying to copy/paste

# Use with a dark background and 256-color terminal!
# Meant for people with rbenv and git.

# You can set your computer name in the ~/.box-name file if you want.

# Borrowing shamelessly from these oh-my-zsh themes:
#   bira
#   robbyrussell
#
# Also borrowing from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

function virtualenv_prompt_info {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
}

function box_name {
  local box="${SHORT_HOST:-$HOST}"
  [[ -f ~/.box-name ]] && box="$(< ~/.box-name)"
  echo "${box:gs/%/%%}"
}

function box_color {
  # https://stackoverflow.com/a/65685722
  local number
  number=$(
    # get predictably-hashed hexidecimal string that depends on hostname
    md5sum <<<"$(box_name)" |
    # meh - take first byte and convert it to decimal
    cut -c3-4 | xargs -i printf "%d\n" "0x{}" |
    # convert 0-255 range into 111-229 range
    awk '{print int($0/255.0*(229-111)+111)}'
  )
  #echo $number
  printf '\e[38;5;%dm' $number $number
}

function tricky_prompt_suffix {
  [[ -n ${TRICKY_PROMPT_SUFFIX} ]] || return
  echo "${TRICKY_PROMPT_SUFFIX}"
}

local ruby_env='$(ruby_prompt_info)'
local git_info='$(git_prompt_info)$(git_remote_status)${FG[255]}'
local virtualenv_info='$(virtualenv_prompt_info)'
local tricky_prompt_suffix='$(tricky_prompt_suffix)'

PROMPT="${FG[040]}%n${FG[239]} @ $(box_color)$(box_name) ${FG[239]}in %B${FG[226]}%~%b${git_info}${ruby_env}${virtualenv_info}${tricky_prompt_suffix}
 \$%{$reset_color%} "

# borrowed from: https://zenbro.github.io/2015/07/23/show-exit-code-of-last-command-in-zsh.html
function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

RPROMPT='$(check_last_exit_code)'

# These inflence git_prompt_info in oh-my-zsh/lib/git.zsh:
ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[239]}on%{$reset_color%} ${FG[255]}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[202]} ✘✘"
ZSH_THEME_GIT_PROMPT_CLEAN="${FG[040]} ✔"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="${FG[013]} <"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="${FG[011]} >>>"
#ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="${FG[018]} ="
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="${FG[208]} !"
# detailed mode shows remote name too
#ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED=yes
# only in detailed mode:
#ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_PREFIX="foo"
#ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_SUFFIX="%{$reset_color$}xxx"
# colors list: https://misc.flogisoft.com/bash/tip_colors_and_formatting#colors1

ZSH_THEME_RUBY_PROMPT_PREFIX=" ${FG[239]}using${FG[243]} ‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

export VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX=" ${FG[239]}using${FG[243]} «"
ZSH_THEME_VIRTUALENV_SUFFIX="»%{$reset_color%}"
