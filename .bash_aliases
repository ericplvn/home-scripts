# Custom Alias
# Display the amount of disk space used by the specified files and for
#  each subdirectory.
alias duh='du -h'
alias duh0='du -h --max-depth=0'
alias duh1='du -h --max-depth=1'

# Shows the amount of disk space used and available on Linux file
#  systems.
alias dfh='df -h' 

alias ssx='ssh -X'
alias emnw='emacs -nw'

# ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Shorten pwd home to ampersand
alias amp='cd ${PWD/"local/home"/home}'

# Grep in code
alias grepc='grep -Inr'