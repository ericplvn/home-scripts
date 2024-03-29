# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [[ `uname -v` == *"Ubuntu"* ]]; then

    # If not running interactively, don't do anything
    case $- in
	*i*) ;;
	*) return;;
    esac

    # don't put duplicate lines or lines starting with space in the history.
    # See bash(1) for more options
    HISTCONTROL=ignoreboth

    # append to the history file, don't overwrite it
    shopt -s histappend

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=1000
    HISTFILESIZE=2000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # If set, the pattern "**" used in a pathname expansion context will
    # match all files and zero or more directories and subdirectories.
    #shopt -s globstar

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	    # We have color support; assume it's compliant with Ecma-48
	    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	    # a case would tend to support setf rather than setaf.)
	    color_prompt=yes
	else
	    color_prompt=
	fi
    fi

    # ANSI color codes
    RS="\[\033[0m\]"    # reset
    HC="\[\033[1m\]"    # hicolor
    UL="\[\033[4m\]"    # underline
    INV="\[\033[7m\]"   # inverse background and foreground
    FBLK="\[\033[30m\]" # foreground black
    FRED="\[\033[31m\]" # foreground red
    FGRN="\[\033[32m\]" # foreground green
    FYEL="\[\033[33m\]" # foreground yellow
    FBLE="\[\033[34m\]" # foreground blue
    FMAG="\[\033[35m\]" # foreground magenta
    FCYN="\[\033[36m\]" # foreground cyan
    FWHT="\[\033[37m\]" # foreground white
    BBLK="\[\033[40m\]" # background black
    BRED="\[\033[41m\]" # background red
    BGRN="\[\033[42m\]" # background green
    BYEL="\[\033[43m\]" # background yellow
    BBLE="\[\033[44m\]" # background blue
    BMAG="\[\033[45m\]" # background magenta
    BCYN="\[\033[46m\]" # background cyan
    BWHT="\[\033[47m\]" # background white

    if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
	xterm*|rxvt*)
	    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	    ;;
	*)
	    ;;
    esac

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
    fi

    # colored GCC warnings and errors
    #export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

    # Add an "alert" alias for long running commands.  Use like so:
    #   sleep 10; alert
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

    # Try to detect (tar|zip)file type and unpack accordingly
    function untar
    {
	local file_type=`file $1 | awk '{ print $2 }'`

	case "$file_type" in
            "POSIX") tar -xvf $1  ;;
            "bzip2") tar -xvjf $1 ;;
            "gzip")  tar -xvzf $1 ;;
            "XZ")    tar -xvJf $1 ;;
            "Zip")   unzip $1     ;;

            *) echo "Unable to determine type of tarball." ;;
	esac
    }
    export -f untar

    function clean_boot_drive
    {
	sudo apt-get purge $(dpkg -l linux-{image,headers}-"[0-9]*" | awk '/ii/{print $2}' | grep -ve "$(uname -r | sed -r 's/-[a-z]+//')")
    }
    export -f clean_boot_drive

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
	    . /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
	fi
    fi
elif [[ `uname -v` == "Darwin"* ]]; then
    # Source global definitions
    if [ -f /etc/bashrc ]; then
	. /etc/bashrc
    fi

    PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
    CLICOLOR=1
    LSCOLORS=ExFxBxDxCxegedabagacad
    alias ls='ls -GFh'
 
else
    # Source global definitions
    if [ -f /etc/bashrc ]; then
	. /etc/bashrc
    fi

    # Prompt
    PS1='[\u@\h:\w]\$ '
fi

# Local bashrc file for specific computers
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi


if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
