# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

#выход если не интерактивная сессия
[[ $- != *i* ]] && return

unset LC_ALL

#bind только для bash в zsh свои
if [ -n "$BASH_VERSION" ]; then

    export HISTSIZE=10000
    export HISTFILESIZE=10000
    export HISTCONTROL=ignoreboth:erasedups
    export HISTIGNORE='l:kill*:mc:ps*:history*'
    export HISTTIMEFORMAT='%F %T '
    PROMPT_COMMAND='history -a'
    shopt -s histappend  # Дописывать историю, а не перезаписывать
    
    # terminal color check
    if [[ "$TERM" =~ (color|256) ]]; then
	color_host="\[\033[38;05;223m\]"
	color_rst="\[\033[00m\]"
	color_dir="\[\033[38;05;151m\]"
	#export TERM=xterm-256color
    fi
    PS1="${debian_chroot:+($debian_chroot)}$color_host\u@\h:$color_dir\w$color_rst\$ "

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

#ssh ключи
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if [ -z "$SSH_CONNECTION" ]; then
    # Запуск агента, если сокет не живой
    if [ ! -S "$SSH_AUTH_SOCK" ]; then
        \rm -f "$SSH_AUTH_SOCK"
	ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
    fi
    # ssh-add только если агент пуст >/dev/null
    ssh-add -l 2>&1 || timeout 20s ssh-add -t 24h 
    # прибиваем лишний процесс от ssh-add
fi

#command alias
[[ -f ~/.alias ]] && source ~/.alias

#LLM api keys
[[ -f ~/.api.keys ]] && source ~/.api.keys

