#!/bin/bash

# Don't do any silly nonsense like keep my path when using su
alias su='su -'

# Allow 'cls' instead of 'clear'
alias cls='clear'

# Add some coloring to grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Configure custom list command
alias ls='ls --color=auto'
alias ll='ls -Agho --color=auto'
alias lt='ls -Aghot --color=auto'

# Helpful for listing huge directories
LESSOPTS="--RAW-CONTROL-CHARS --quit-if-one-screen --chop-long-lines --no-init"
alias lesss='ls --color=always | less $LESSOPTS'
alias lessl='ls -Agho --color=always | less $LESSOPTS'
alias lesst='ls -Aghot --color=always | less $LESSOPTS'

# Default to creating intermediate directories
alias mkdir='mkdir -p'

# Chainload ~/.bash_python_aliases
if [ -e ~/.bash_python_aliases ]; then
	. ~/.bash_python_aliases
fi

# Chainload ~/.bash_functions
if [ -e ~/.bash_functions ]; then
	. ~/.bash_functions
fi

