# Ensure XDG used for portable apps
export XDG_CONFIG_HOME=$HOME/.config

# TERM
export TERM="xterm-256color"

# Load homebrew if it's there
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Go bin path
if [[ -f "/opt/homebrew/bin/go" ]] then
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

# Local bins
export PATH="$HOME/.local/bin:$PATH"

# Setup Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add zsh plugins
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
compinit -d ~/.cache/zsh/zcompdump
zinit cdreplay -q

# Speed up escape key to cancel selection
KEYTIMEOUT=10

# Key bindings
bindkey '^y' autosuggest-accept
bindkey '^ ' forward-word
bindkey '^[[Z' reverse-menu-complete
bindkey -M menuselect '^[' undo
bindkey '^k' up-history
bindkey '^j' down-history
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward

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
alias lg='lazygit'
alias gst='git status'
alias ga='git add'
alias gd='git diff'
alias gdt='git difftool'
alias gdc='git diff --cached'
alias gdtc='git difftool --cached'
alias gp='git push'
alias gc='git commit'
alias gf='git fetch'
alias gri='git rebase --interactive'
alias grhh="git reset --hard HEAD"

# Bat
if command -v bat &> /dev/null; then
  alias cat='bat'
fi

# Direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# Oh My Posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/theme.toml)"
fi

# FZF
source <(fzf --zsh)
export FZF_CTRL_R_OPTS="--bind=ctrl-y:accept"
functions[__fzf_defaults_orig]=$functions[__fzf_defaults]

__fzf_defaults() {
  if [ -f "${HOME}/Code/ttyc/generated/env.sh" ]; then
    source "${HOME}/Code/ttyc/generated/env.sh"

    if [ "$THM_DIALECT" = "rose-pine" ]; then
      export FZF_DEFAULT_OPTS="
      --info=right
      --border=rounded
      --margin=1
      --layout=reverse
      --color=fg:${THM_SUBTLE},bg:${THM_BASE},hl:${THM_ROSE}
      --color=fg+:${THM_TEXT},bg+:${THM_OVERLAY},hl+:${THM_ROSE}
      --color=border:${THM_HIGHLIGHT_MED},header:${THM_PINE},gutter:${THM_BASE}
      --color=spinner:${THM_GOLD},info:${THM_FOAM}
      --color=pointer:${THM_IRIS},marker:${THM_LOVE},prompt:${THM_SUBTLE}"
    fi

    if [ "$THM_DIALECT" = "catppuccin" ]; then
      export FZF_DEFAULT_OPTS="
      --info=right
      --border=rounded
      --margin=1
      --layout=reverse
      --color=bg+:${THM_SURFACE0},bg:${THM_BASE},spinner:${THM_ROSEWATER},hl:${THM_RED}
      --color=fg:${THM_TEXT},header:${THM_RED},info:${THM_MAUVE},pointer:${THM_ROSEWATER}
      --color=marker:${THM_LAVENDER},fg+:${THM_TEXT},prompt:${THM_MAUVE},hl+:${THM_RED}
      --color=selected-bg:${THM_SURFACE1}
      --color=border:${THM_OVERLAY0},label:${THM_TEXT}"
    fi

    __fzf_defaults_orig "$@"
  fi
}

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Brew
HOMEBREW_NO_ENV_HINTS=true

# Use nvim for man
export MANPAGER='nvim +Man!'
export EDITOR='nvim'

# system specific config
[ -s "$HOME/.zshrc" ] && source "$HOME/.zshrc"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# continue fns
[ -s "$HOME/.config/zsh/.zshrc.continue" ] && source "$HOME/.config/zsh/.zshrc.continue"
