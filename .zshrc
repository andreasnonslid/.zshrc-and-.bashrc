# The look

PROMPT=$'%F{yellow}%~%f\n %# '

# Import nice modules
export PATH="$PATH:/usr/bin"

# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/c/Users/11899/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install

# Store original prompt for restoration only if it hasn't been stored yet
if [[ -z $ORIG_PROMPT ]]; then
  ORIG_PROMPT="$PROMPT"
fi

# Function to update the Zsh prompt with Vi mode information
function zle-line-init zle-keymap-select {
  local mode_name
  case ${KEYMAP} in
    vicmd)
      mode_name='%F{blue}[NORMAL]%f'
      ;;
    main|viins)
      mode_name='%F{green}[INSERT]%f'
      ;;
    *)
      # default case (you can leave this empty if you want)
      mode_name='%F{black}[UNKNOWN]%f'
      ;;
  esac
  PROMPT="%{$fg[green]%}${mode_name}%{$reset_color%} $ORIG_PROMPT"
  zle reset-prompt
}

# Register the function for Zsh to use
zle -N zle-line-init
zle -N zle-keymap-select

# Now your other aliases, functions, etc.



# Create a directory and navigate into it
# Usage: mkcd [DIRECTORY_NAME]
mkcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

# Terminal niceties
alias cls='clear'

# Simplified directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# File handling
alias rmf='rm -f'  # Remove a file forcefully
alias rmr='rm -r'  # Remove directories recursively
alias cpr='cp -r'  # Copy directories recursively
alias mvr='mv -r'  # Move directories recursively

# Search
alias grep='grep --color=auto'  # Colored grep
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Directory handling
alias ll='ls -l'  # Long listing
alias la='ls -a'  # Show hidden files
alias l='ls -CF'  # List in column format

# Git related
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log'
alias gd='git diff'
alias gcl='git clone'
alias gco='git checkout'
alias gbr='git branch'
alias gpl='git pull'
alias gr='git rebase'
alias gbl='git branch --list'
alias gstart='gco master && gpl && gco -b '

# Show Help Function
show_help() {
  echo "Extensive List of Useful Functions:"
  echo ""
  echo "Navigation:"
  echo "  .. , ... , .... , .....  : Navigate to parent directories at different levels."
  echo "  mkcd [DIRECTORY_NAME]   : Create a directory and navigate into it."
  echo ""
  echo "File Handling:"
  echo "  rmf                     : Forcefully remove a file."
  echo "  rmr                     : Remove directories recursively."
  echo "  cpr                     : Copy directories recursively."
  echo "  mvr                     : Move directories recursively."
  echo ""
  echo "Search:"
  echo "  grep                    : Perform a search with colored results."
  echo "  fgrep                   : Fixed pattern search with colored results."
  echo "  egrep                   : Extended pattern search with colored results."
  echo ""
  echo "Directory Handling:"
  echo "  ll                      : Long listing of files and directories."
  echo "  la                      : List all entries including hidden ones."
  echo "  l                       : List files in columns."
  echo ""
  echo "Git Commands:"
  echo "  gs                      : git status"
  echo "  ga                      : git add"
  echo "  gc                      : git commit"
  echo "  gp                      : git push"
  echo "  gl                      : git log"
  echo "  gd                      : git diff"
  echo "  gcl                     : git clone"
  echo "  gco                     : git checkout"
  echo "  gbr                     : git branch"
  echo "  gpl                     : git pull"
  echo "  gr                      : git rebase"
  echo "  gbl                     : git branch --list"
  echo "  gstart                  : gco master && gpl && gco -b"
}

# Register help function
alias zhelp='show_help'

# AutoStore commands

alias cdc='cd c:/'
alias cdASMonoRepo='cd c:/dev/ASMonoRepo'
alias cdFusion='cd c:/dev/ASMonoRepo/products/port/buddy-port'

# Function to interface with TortoiseGit
tgit() {
  if [[ -z $1 ]]; then
    echo "Error: No argument supplied. Use 'log', 'commit', etc."
    return 1
  fi

  # Mapping of common git actions to TortoiseGit commands
  case "$1" in
    log)
      /c/Program\ Files/TortoiseGit/bin/TortoiseGitProc.exe /command:log /path:.
      ;;
    commit)
      /c/Program\ Files/TortoiseGit/bin/TortoiseGitProc.exe /command:commit /path:.
      ;;
    # Add more cases here for other TortoiseGit functionalities
    *)
      echo "Error: Unknown argument. Use 'log', 'commit', etc."
      return 1
      ;;
  esac
}

# Function to reload the Zsh configuration
reloadZSH() {
  source $HOME/.zshrc
  echo "Zsh configuration reloaded."
}

# Function to open the Zsh configuration in VSCode
editZSH() {
  code $HOME/.zshrc
  echo "Opening Zsh configuration in VSCode."
}

alias wsl="/c/Windows/System32/wsl.exe"

winCD() {
    local win_path=$1
    local unix_path

    # Replace backslashes with forward slashes and "C:" with "/c"
    unix_path="${win_path//\\//}"
    unix_path="${unix_path/:/}"

    # Convert drive letter to lowercase and prepend a slash
    local drive_letter=${unix_path:0:1}
    drive_letter=$(echo "$drive_letter" | /usr/bin/tr '[:upper:]' '[:lower:]')
    unix_path="/$drive_letter${unix_path:1}"

    # echo "$unix_path"
    cd "$unix_path"
}
