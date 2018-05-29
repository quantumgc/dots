# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        history-beginning-search-backward
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      history-beginning-search-backward
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
# End of lines added by compinstall

# Source global definitions
if [ -f /etc/zshrc ]; then
	. /etc/zshrc
fi

if [ -r ~/.profile ]; then . ~/.profile; fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions


# Prompt
if [ $(id -u) = 0 ]; then
    PS1="\u@\h:\W\# "
else
    export PROMPT_COMMAND='PS1="%F{yellow}[%n%f@%F{yellow}%m%f:%F{red}%1~%F{yellow}]%F{blue}%#%f "'
    PS1="%F{yellow}[%n%f@%F{yellow}%m%f:%F{red}%1~%F{yellow}]%F{blue}%#%f "
fi

export PS1

autoload -Uz promptinit
promptinit

# wal
cat ~/.cache/wal/sequences &&

# Aliases

# neovim
alias nv="nvim"

# Git
alias g="git"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias h="cd $HOME"

# amarok control
alias fwd='amarok -f'
alias bwd='amarok -r'
alias pau='amarok -t'

# Removal
alias rm='rm -i'

# Clearing and listing
alias clear="echo -e '\0033\0143'; clear"
alias cl="clear"
alias cls='clear; exa'

# making directories
alias mkdir='mkdir -p'
alias mk='mkdir'

# pyth
alias pyth="python3 $PROGDIR/pyth/pyth.py"

# Make and change to directory
mkcd () { mkdir "$1"; cd "$1";}

# Unzip all zip files into directories with the basename of the source file
multiunzip () {
    for file in *.zip ; do dir="$(basename "$file" .zip)"; mk "$dir"; unzip "$file" -d "$dir"; done
}

multizip () {
    for dir in */; do name="$(basename "$dir" /)"; zip -r "$name" "$dir"; done
}
