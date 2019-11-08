set -o emacs

if [ -f ~/.zplug/init.zsh ]; then
    source ~/.zplug/init.zsh
    zplug 'themes/garyblessington', from:oh-my-zsh, as:theme
    zplug 'b4b4r07/enhancd', use:init.sh
    zplug 'zsh-users/zsh-syntax-highlighting', defer:2
    zplug 'zsh-users/zsh-completions'
    zplug "plugins/colored-man-pages", from:oh-my-zsh
    if ! zplug check --verbose; then
        zplug install
    fi
    zplug load
fi

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

autoload -U compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "`dircolors`"
zstyle ':completion:*:default' menu select=1

bindkey '^[[Z' reverse-menu-complete

setopt hist_ignore_dups
setopt extended_glob

alias ls='ls --group-directories-first --color -G -F'
alias rm='rm -i'
