# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

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
HISTSIZE=-1
HISTFILESIZE=-1

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

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\[\033[01;32m\][$(git branch 2>/dev/null | grep "^*" | colrm 1 2)]\[\033[00m\]:λ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w $ '
#fi

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\] \w\[\033[00m\]\[\033[01;32m\]$(parse_git_branch)\[\033[00m\]\nλ '
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

# some more ls aliases

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# Allows vi mode in bash
set -o vi

# To enable GHC - Glashow Haskell Compiler
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# Disable Ctrl + S
stty -ixon

# PATH VARIABLE DECLARATIONS
export PATH="/home/carneca/.local/bin:$PATH"
export PATH="/home/carneca/local/bin:$PATH"
export PATH="/home/carneca/.storage/youtube-dl-music:$PATH"
export PATH="/home/carneca/local:$PATH"
export PATH="/home/carneca/Documents/Scripts:$PATH"
export PATH="/opt/Stata/stata14/64-bit:$PATH"
export PATH="/.local/bin:$PATH"
export PATH="/home/carneca/.cabal/bin/stylish-haskell:$PATH"
export PATH="/usr/share/texmf-dist/scripts/latexindent:$PATH"
export GOPATH=~/.config/gopath
export PATH=$GOPATH:$GOPATH/bin:${PATH}
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .stack --ignore .cabal --ignore .cache --ignore .git --ignore .vim --ignore .local -l -g ""'

# VARIABLE DECLARATIONS
export BFETCH="/home/carneca/Documents/Python/automation/bfetch"
export TERMINAL="alacritty"

#SPOTIFY DOWNLOADER
export SPOTIPY_CLIENT_ID='2ddda6a007494defad3ec0d140123e8e'
export SPOTIPY_CLIENT_SECRET='faf826ce11234872930b6f138dcc5cc1'
export SPOTIPY_REDIRECT_URI='https://www.slickremix.com/docs/get-api-key-for-youtube/'
export YOUTUBE_DEV_KEY='AIzaSyBl7qzvYb4ojkwFNXBNeFQQC-Dor_Ich8E'

# PYTHON SCRIPTS
export EDITOR=$(which vim)
export PYTHON_DIR='/home/carneca/Documents/Python'
alias bfetch='cd ${PYTHON_DIR}/automation/bfetch && python bfetch.py'
alias fsort='python ${PYTHON_DIR}/automation/file_sort/file_sorter.py'
alias dsort='cd /home/carneca/Downloads && python ${PYTHON_DIR}/automation/pdf_sort/pdf_sort.py'
alias draw='inkscape-figures watch;python3 /home/carneca/Documents/Scripts/inkscape-shortcut-manager/main.py'

# GIT SHORTCUTS
alias gca='git commit -a'
alias gcam='git commit -am'
alias gcma='git commit -am'
alias gcm='git commit -m'
alias gc='git commit'
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# CD SHORTCUTS
alias f='vifm .'
alias fd='pushd $(tree -dfai $HOME | fzf)'
alias fw='vim $(tree -fi $HOME | fzf)'
alias v='vim'
alias c='clear'
alias z='zathura'
alias lat='cd ~/Documents/Latex'
alias pyf='cd ~/Documents/Python'
alias d='cd ~/Documents/'
alias dl='cd ~/Downloads/'
alias dots='cd ~/Documents/dotfiles/'
alias jnote='cd ${PYTHON_DIR}/notebooks && source $PWD/env/bin/activate && jupyter notebook 2> /dev/null ; exit'
alias coll='cd /home/carneca/Documents/College/4/Michaelmas'
 

# PROGRAM SHORTCUTS
output=$(which exa 2> /dev/null)
if [ $? -eq 0 ]
    then 
    alias ls='exa --group-directories-first'
    alias ll='exa -alF --group-directories-first'
    alias la='exa -a --group-directories-first'
    else
    alias ll='ls -l'
    alias la='ls -a'

fi
# alias l='exa -CF --group-directories-first'
alias pydebug='python -m pdb'
alias act='source $PWD/env/bin/activate'
alias sdn='shutdown now'
alias texclean='rm -f *.synctex.gz *.aux *.log *.fls *.fdb_latexmk *.dvi *.bbl *.blg'
alias xc='xclip -selection clipboard'
alias stata='xstata-mp && exit'
alias sxhkdreset='killall sxhkd && sxhkd &'
alias bp='bpython'
alias musicdl='youtube-dl -x --audio-format mp3 '
alias drun='docker run -it --rm '
alias icat="kitty +kitten icat"

# FILE SHORTCUTS
alias bib='vim ~/Documents/Latex/bibmaster.bib'
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias sxhkdrc='vim ~/.config/sxhkd/sxhkdrc'
alias snipp='vim ~/.vim/my-snippets/tex.snippets'
alias psnipp='vim ~/.vim/my-snippets/python.snippets'
alias config='/usr/bin/git --git-dir=/home/carneca/.cfg/ --work-tree=/home/carneca'
