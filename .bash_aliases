# Allow 'cls' instead of 'clear'
alias cls='clear'

# Add some coloring
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Configure custom list command
alias ll='ls -Agho --color=auto'

# Helpful for listing huge directories
LESSOPTS="--RAW-CONTROL-CHARS --quit-if-one-screen --chop-long-lines --no-init"
alias heads='ls --color=always | head'
alias headl='ls -Agho --color=always | head'
alias headt='ls -Aghot --color=always | head'
alias lesss='ls --color=always | less $LESSOPTS'
alias lessl='ls -Agho --color=always | less $LESSOPTS'
alias lesst='ls -Aghot --color=always | less $LESSOPTS'

# Default to creating intermediate directories
alias mkdir='mkdir -p'

