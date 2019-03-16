  export ZSH="/home/equipo/.oh-my-zsh"

##### oh my zsh ###########
ZSH_THEME="spaceship"
SPACESHIP_CHAR_SYMBOL="  "
SPACESHIP_GIT_PREFIX="en "
SPACESHIP_GIT_SYMBOL=
SPACESHIP_GIT_BRANCH_PREFIX=" "
SPACESHIP_EXEC_TIME_PREFIX="Tiempo: "

# Bullet-train custom
BULLETTRAIN_PROMPT_ORDER=(
    time
    context
    dir
    git
)

plugins=(
  git
)
BULLETTRAIN_CONTEXT_DEFAULT_USER=equipo

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder


source $ZSH/oh-my-zsh.sh

PATH="$HOME/scripts:$PATH"
export PATH

alias drive="~/scripts/grive-sync.sh"
alias DRIVE="~/scripts./grive-sync.sh"
alias emc="emacsclient -c"
alias emt="emacsclient -t"
alias ranger="~/.sources/ranger/ranger.py"
#neofetch | lolcat
neofetch --ascii "$(fortune-es|cowsay -W 30)" | lolcat 
alias E="SUDO_EDITOR=\"emacsclient -c -a emacs\" sudoedit"

###### NNN #################
export NNN_TRASH=1
export NNN_OPS_PROG=1
export NNN_SCRIPT=/home/equipo/scripts
export NNN_BMS='h:~;r:/run/media/equipo;d:~/Drive;D:~/Descargas;c:~/.config'
export LC_COLLATE="C"
