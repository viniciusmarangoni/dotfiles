# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# set editor
export EDITOR=/usr/bin/vim

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Add to history instead of overriding it
shopt -s histappend

# History lenght
HISTSIZE=999999999
HISTFILESIZE=3000000
HISTTIMEFORMAT="%F %T -> "
PROMPT_COMMANT="history -a"

# Window size sanity check
shopt -s checkwinsize

# autocd
shopt -s autocd

# Colored XTERM promp
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Colored prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Prompt
if [ -n "$SSH_CONNECTION" ]; then
    export PS1="\[$(tput setaf 1)\]┌─╼\[$(tput setaf 5)\] \h \[$(tput setaf 7)\][\w]\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]└────╼ \[$(tput setaf 7)\][ssh]\"; else echo \"\[$(tput setaf 1)\]└╼ \[$(tput setaf 7)\][ssh]\"; fi) \[$(tput setaf 7)\]"
else
    export PS1="\[$(tput setaf 12)\]┌─╼\[$(tput setaf 6)\] \h \[$(tput setaf 12)\][\w]\n\[$(tput setaf 12)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 12)\]└────╼\"; else echo \"\[$(tput setaf 12)\]└╼\"; fi) \[$(tput setaf 7)\]"
fi

trap 'echo -ne "\e[0m"' DEBUG

    # Color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias ls='ls -F --color=auto'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Auto-completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Color output
export LESS=-R
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

# my aliases
alias grep='grep --colour=always'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

if [ -f "/etc/arch-release" ]; then
    alias python='/usr/bin/python2.7'
fi

alias cleanlog='adb logcat -c; tput reset; adb logcat'
alias apkx='echo "apkx -c enjarify"; apkx -c enjarify'
alias listpkg='echo "adb shell pm list packages -f"; adb shell pm list packages -f'

# Open files with the right program
# Example: open myfile.pdf
open(){
    xdg-open $1 > /dev/null 2>&1 &
}

function cd_up() {
    cd $(printf "%0.0s../" $(seq 1 $1));
}
alias 'cd..'='cd_up'

# Save the original PATH
if [ -z $ORIGINAL_PATH ]; then
    export ORIGINAL_PATH=$PATH
fi

# Set PATH variable
if [ -f ~/.bash_path ]; then
    # The right wat to personalize your PATH is
    #
    # CUSTOM_PATH=/home/user/tool1
    # CUSTOM_PATH=$CUSTOM_PATH:/home/user/tool2
    # CUSTOM_PATH=$CUSTOM_PATH:/home/user/tool3
    # export PATH=$ORIGINAL_PATH:$CUSTOM_PATH
    #
    # If you reload your bashrc it will not be so big
    source ~/.bash_path
fi

# Put in this file the configs that you dont want to
# be followed by yadm
if [ -f ~/.bash_custom_config ]; then
    source ~/.bash_custom_config
fi

source /usr/share/autojump/autojump.bash
