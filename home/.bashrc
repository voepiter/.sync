# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

#выход если не интерактивная сессия
[[ $- != *i* ]] && return

# цветной `ls' to be colorized:
export LS_OPTIONS='-lAh --time-style=long-iso --color=auto  --group-directories-first'
eval "$(dircolors -b ~/.dircolors)"
alias l="ls $LS_OPTIONS"

alias rs='rsync -avz'
alias e='mcedit'
alias i='sudo apt -y install'
alias g='grep --color=auto'
alias du='grc du -h -d 1'
alias diff='diff -U0'
alias ss='ss -tulpn |awk '\''{split($7, a, "\""); print $1,a[2],$5}'\'''

unset LC_ALL

#bind только для bash в zsh свои
if [ -n "$BASH_VERSION" ]; then

    export HISTSIZE=10000
    export HISTFILESIZE=10000
    export HISTCONTROL=ignoreboth:erasedups
    export HISTIGNORE='l:kill*:mc:ps*:history*'
    export HISTTIMEFORMAT='%F %T '
    PROMPT_COMMAND='history -a'

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac
    color_prompt=yes

    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[38;05;223m\]\u@\h\[\033[00m\]:\[\033[38;05;151m\]\w\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt
    #export TERM=xterm-256color

    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind -x '"\C-r"':reset
    bind 'set bell-style none'

    # Настройка выделения для Shift+Стрелки в WSL/Windows Terminal
    bind '"\e[1;2D": backward-word'      # Shift+Left
    bind '"\e[1;2C": forward-word'       # Shift+Right
    bind '"\e[1;2A": beginning-of-line'  # Shift+Up
    bind '"\e[1;2B": end-of-line'        # Shift+Down
fi

# добавляем ssh ключи в агент 
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if [ -z "$SSH_CONNECTION" ] && [ -z "$SSH_TTY" ]; then
    # Запускаем агент если не запущен
    if ! \ss -a | grep -q "$SSH_AUTH_SOCK"; then
        rm -f "$SSH_AUTH_SOCK"
	ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
    fi

    # проверяем ключ в агенте добавляем если нет
    ssh-add -l | grep SHA || ssh-add -t 24h
fi

#LLM api keys
[[ -f ~/.api.keys ]] && source ~/.api.keys

#[[ -f ~/.profile ]] && export PATH="$HOME/.local/bin:$PATH"

