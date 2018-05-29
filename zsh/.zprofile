# .bash_profile

# Get the aliases and functions
if [ -f ~/.zshrc ]; then
	. ~/.zshrc
fi
if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.zshrc ]; then . ~/.zshrc; fi;; esac

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
