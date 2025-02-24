if status is-interactive
  # Commands to run in interactive sessions can go here 
  if test "$SHLVL" -le 2

    # 1pasword
    # if test -n $OP_STATUS --quiet
    #   op signin && set -gx OP_STATUS "connected."
    # end 

     # TMUX Condition to avoid running tmux in session into a session
    if not string match -r 'xtmux' $TERM --quiet
      tmux
    end
  end
  
end

set DOCKER_CLI_EXPERIMENTAL enabled
set XDG_CONFIG_HOME /Users/yassin.bousaadi
set -gx EDITOR (which lvim)

# Abbreviations 
abbr gc "git clone"
abbr gg "lazygit"
abbr dc "docker"
abbr dd "lazydocker"
abbr l "lvim"
abbr c "bat"
abbr py "python3"

# Docker
abbr dc "docker"
abbr dci "docker image"
abbr dcct "docker container"
abbr dcc "docker compose"
abbr dockerprune "docker system prune -a"

# Tf abbrevations
abbr tf "terraform"
abbr tfa "terraform apply"
abbr tfp "terraform plan"
abbr tff "terraform fmt"
abbr tfi "terraform init"

# Aliases
alias l "lvim"
alias cat "bat -p"
alias c "bat"

alias ctop 'TERM="(string-replace tmux term $TERM)" /opt/homebrew/bin/ctop'

# Tooling 
direnv hook fish | source
zoxide init fish | source
fzf --fish | source
op completion fish | source
