# Load homebrew if it's there
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load modules
autoload edit-command-line; zle -N edit-command-line
zle -N cancel-completion

# Enable vim mode
bindkey -v
bindkey -M vicmd V edit-command-line

# Load completions
autoload -Uz compinit
zmodload -i zsh/complist
compinit
zinit cdreplay -q

# Speed up escape key to cancel selection
KEYTIMEOUT=10

# Key bindings
bindkey '^p' autosuggest-accept
bindkey '^ ' forward-word
bindkey '^[[Z' reverse-menu-complete
bindkey -M menuselect '^[' undo

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# Aliases
alias ls='eza'
alias vim='nvim'
alias mux='tmuxinator'

# Git
alias gst='git status'
alias ga='git add'
alias gd='git difftool'
alias gdc='git difftool --cached'
alias gp='git push'
alias gc='git commit'

# Bat
if command -v bat &> /dev/null; then
  export BAT_THEME='Catppuccin Frappe'
  alias cat='bat'
fi

# Shell integrations
export FZF_CTRL_R_OPTS="--layout=reverse --bind=ctrl-y:accept"
source <(fzf --zsh)

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/theme.toml)"
fi

# FZF
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
--color=selected-bg:#51576d \
--color=border:#414559,label:#c6d0f5"

# Source system specific config
if [[ -f  "$HOME/.zshrc" ]] then
  source "$HOME/.zshrc"
fi
