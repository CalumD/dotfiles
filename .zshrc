#PROMPT, Colours and Terminal Style ############################################
export CLICOLOR=1
PROMPT="[%(?.%F{green}.%F{red})&%f]"                  # Status of last command green=success red=failure
PROMPT+='['                                           # Display Opening Bracket
PROMPT+='%F{red}%n'                                   # Display User Name
PROMPT+='%f@'                                         # Display an @
PROMPT+='%F{red}%m'                                   # Display Hostname
PROMPT+='%f:'                                         # Separate user/host from current dir
PROMPT+='%F{magenta}%~'                               # Show current working dir
PROMPT+='%f]'                                         # Reset Colour and terminate main prompt
PROMPT+='%(!.%F{red}#.%F{green}$)%f '                 # Set the prompt character based on elevated privilage

RPROMPT='[%F{red}%*%f]'                               # Set the right side prompt to the current time HH:MM:SS



# Alias' #######################################################################
# Commands
alias ls='ls -G -v'                                            # Colourise ls
alias python="python3"                                         # Enforce python3 unless python2 explicitly selected
alias ..='cd ../'                                              # Go back 1 dir
alias ...='cd ../../'                                          # Go back 2 dirs
alias ....='cd ../../../'                                      # Go back 3 dirs
alias update='brew update && sleep 3 && brew upgrade'          # Update homebrew
alias ll='ls -lha'                                             # Shortcut for detailed ls
alias dns='sshpi cat /etc/pihole/custom-hosts.list | grep $1'  # Search home network DNS table for given input
alias h='history 0 | grep $1'                                  # Search command history for given input
alias d='docker '                                              # Short for docker
alias drmi='d rmi '                                            # Removing docker images
alias drm='d rm '                                              # Removing docker containers
alias dls='d ps -a && echo "\nImages:" && d images'            # Listing docker containers and images


# SSH hosts
alias sshpi="ssh pi@pihole"                                    # Home network PiHole
alias sshpear="ssh pi@pi.air"                                  # Home network Project Pi
alias sshusg="ssh CLUM@usg"                                    # Home network Unifi Security Gateway
alias sshck="ssh CLUM@cloudkey"                                # Home network Unifi Cloud Key
alias sshigor="ssh root@igor"                                  # Home network Unraid Server



# Settings #####################################################################
export JAVA_HOME=$(/usr/libexec/java_home)           # Set Java Home
setopt hist_ignore_all_dups                          # remove older duplicate entries from history
setopt hist_reduce_blanks                            # remove superfluous blanks from history items
setopt share_history                                 # share history between different instances of the shell



# partial completion suggestions ###############################################
# Deal with auto-suggesting with multi-auto-expansion
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' #Case insensitve autocompletion

# Ensure that docker commands complete with short option stacking properly instead of printing all autocompleteable commands
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Additional Configs
bindkey '^[[Z' reverse-menu-complete       # Set shift-tab to go back an autocomplete option
bindkey "^[[A" history-search-backward     # Use Current context specifics when history searching Backwards
bindkey "^[[B" history-search-forward      # Use Current context specifics when history searching Forward
autoload bashcompinit && bashcompinit      # load bashcompinit for some old bash completion
autoload -Uz compinit && compinit          # Enable the completions



# FUNCTIONS ###################################################################

# Find/f - Recursively Search directories below/including current for filename
f() {
    find . -name "*$1*"
}

# Docker build the given container name
db() {
    d build -t agentclum/$1 ${@:2} .
}

# Run the given docker container
dr() {
    d run --name $1 ${@:2} agentclum/$1
}
