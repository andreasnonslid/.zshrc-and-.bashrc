# Foreground Colors
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"
ORANGE="\033[0;38;5;208m"
PINK="\033[0;38;5;206m"
LIGHT_GRAY="\033[0;38;5;250m"
GRAY="\033[0;38;5;240m"
LIGHT_RED="\033[0;38;5;196m"
LIGHT_GREEN="\033[0;38;5;46m"
LIGHT_YELLOW="\033[0;38;5;226m"
LIGHT_BLUE="\033[0;38;5;75m"
BOLD_BLACK="\033[1;30m"
BOLD_RED="\033[1;31m"
BOLD_GREEN="\033[1;32m"
BOLD_YELLOW="\033[1;33m"
BOLD_BLUE="\033[1;34m"
BOLD_PURPLE="\033[1;35m"
BOLD_CYAN="\033[1;36m"
BOLD_WHITE="\033[1;37m"

# Background Colors
BG_BLACK="\033[40m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_YELLOW="\033[43m"
BG_BLUE="\033[44m"
BG_PURPLE="\033[45m"
BG_CYAN="\033[46m"
BG_WHITE="\033[47m"
BG_ORANGE="\033[48;5;208m"
BG_PINK="\033[48;5;206m"
BG_LIGHT_GRAY="\033[48;5;250m"
BG_GRAY="\033[48;5;240m"
BG_LIGHT_RED="\033[48;5;196m"
BG_LIGHT_GREEN="\033[48;5;46m"
BG_LIGHT_YELLOW="\033[48;5;226m"
BG_LIGHT_BLUE="\033[48;5;75m"

# Other
NC="\033[0m"   # No Color
UNDERLINE="\033[4m"

# Initial values
last_exit_status="✔"
exit_status_color="$LIGHT_GREEN"
git_info=""
jobs_count=""

# Function to get the return value of the last command
update_exit_status() {
    if [[ $? == 0 ]]; then
        last_exit_status="✔"  # Green color for success
        exit_status_color="$LIGHT_GREEN"
    else
        last_exit_status="✘"  # Red color for failure
        exit_status_color="$LIGHT_RED"
    fi
}

# Function to get git info
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# This function updates the prompt.
update_git_info() {
    local branch
    branch=$(parse_git_branch)
    if [[ -n $branch ]]; then
        git_info=" ($branch)"
    else
        git_info=""
    fi
}

# Function to get count of background jobs
update_jobs_count() {
    local count=$(jobs -p | wc -l)
    if [[ $count -gt 0 ]]; then
        jobs_count=" [$count]"
    else
        jobs_count=""
    fi
}

# The look
setPS1() {
    PS1='\['"$exit_status_color"'\]$last_exit_status\['"$PINK"'\]$jobs_count\['"$LIGHT_BLUE"'\]\w \['"$WHITE"'\]\$\['"$LIGHT_YELLOW"'\]$git_info\['"$WHITE"'\] \t\n% '
}

# Main function which does everything in order
# Need to do this so they behave as expected (not concurrently)
updateStatusLine() {
    update_exit_status
    update_git_info
    update_jobs_count
    setPS1
}

# The commands which are run every time a command is entered in the shell
PROMPT_COMMAND="updateStatusLine"


# Import nice modules
export PATH="$PATH:/usr/bin"

# Aliases and Functions
mkcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias rmf='rm -f'
alias rmr='rm -r'
alias cpr='cp -r'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'
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
alias gstart='gco master && gpl && gco -b'
alias gnevermind='git reset --hard HEAD && git clean -d -f'

show_help() {
    echo -e "Extensive List of Useful Functions:\n"
    # (rest of the function is unchanged)
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
    echo "  gnevermind              : git reset --hard HEAD && git clean -d -f"
}

alias bashhelp='show_help'
alias cdc='cd c:/'
alias cdASMonoRepo='cd c:/dev/ASMonoRepo'
alias cdFusion='cd c:/dev/ASMonoRepo/products/port/buddy-port'

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

# Bash doesn't have an inbuilt reload function, so we create one.
reloadBASH() {
    source $HOME/.bashrc
    echo "Bash configuration reloaded."
}

# Function to open the Bash configuration in VSCode
editBASH() {
    code $HOME/.bashrc
    echo "Opening Bash configuration in VSCode."
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
