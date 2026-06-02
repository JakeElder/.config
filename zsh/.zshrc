# colors
export TERM="xterm-256color"
[ -s "$HOME/.config/tc/.tc" ] && source "$HOME/.config/tc/.tc"

# prompt
if [[ $(hostname) == "pi" ]]; then
  PROMPT='%F{magenta}%f %F{white}%~%f %F{blue}>%f '
elif [[ $(hostname) == "relay" ]]; then
  PROMPT='%F{magenta}󰖂%f %F{white}%~%f %F{blue}>%f '
else
  PROMPT='%F{white}%~%f %F{blue}>%f '
fi

# paths
export XDG_CONFIG_HOME=$HOME/.config
export PATH="$HOME/.local/bin:$PATH"
export COLIMA_HOME="$HOME/.colima"

# ls colors
if [[ "$(uname)" == "Darwin" ]]; then
  export CLICOLOR=1
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
else
  alias ls='ls --color=auto'
fi

# cursor reset after every command
reset_cursor() { printf '\033[?25h\033[0 q'; }
# reset_cursor() { printf '\u0e1f\u0e31\u0e04\u0e22\u0e39\u0e40\u0e19\u0e2a\u0e42\u0e01'; }
precmd_functions+=(reset_cursor)

# vi mode
bindkey -v
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd V edit-command-line

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
bindkey "^k" up-history
bindkey "^j" down-history

# homebrew
for p in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
  [[ -x "$p/bin/brew" ]] && eval "$($p/bin/brew shellenv)" && break
done

if command -v brew &>/dev/null; then
  BREW_PREFIX="$(brew --prefix)"
  fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)
  autoload -Uz compinit && compinit

  [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  bindkey "^y" autosuggest-accept
  bindkey "^@" forward-word
fi

# git aliases
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gdt="git difftool"
alias gdtc="git difftool --cached"
alias gst="git status"

# nvim
if command -v nvim &>/dev/null; then
  export MANPAGER='nvim +Man!'
  export EDITOR='nvim'
  vim() {
    while true; do
      command nvim "$@"
      [[ $? -eq 100 ]] || break
      set -- -c 'AutoSession restore'
    done
  }
  alias nvim="vim"
fi

# fzf
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
  export FZF_CTRL_R_OPTS="--bind=ctrl-y:accept"
  export FZF_DEFAULT_OPTS="
    --info=right
    --layout=reverse
    --border=rounded
    --margin=1
    --color=fg:$TC_FZF_FG,bg:$TC_FZF_BG,hl:$TC_FZF_HL
    --color=fg+:$TC_FZF_FG_PLUS,bg+:$TC_FZF_BG_PLUS,hl+:$TC_FZF_HL_PLUS
    --color=border:$TC_FZF_BORDER,header:$TC_FZF_HEADER,gutter:$TC_FZF_GUTTER
    --color=spinner:$TC_FZF_SPINNER,info:$TC_FZF_INFO
    --color=pointer:$TC_FZF_POINTER,marker:$TC_FZF_MARKER,prompt:$TC_FZF_PROMPT"
fi

# forgit
if [[ -n "$BREW_PREFIX" && -f "$BREW_PREFIX/share/forgit/forgit.plugin.zsh" ]]; then
  export FORGIT_NO_ALIASES=1
  export FORGIT_LOG_FORMAT="%C(yellow)%h %C(white)%s %C($TC_MAUVE)%cr%C(reset)"
  export FORGIT_PAGER='delta --config ~/.config/delta/config --features=tc --width ${FZF_PREVIEW_COLUMNS:-$COLUMNS}'
  export FORGIT_FZF_DEFAULT_OPTS="--bind='alt-j:preview-half-page-down,alt-k:preview-half-page-up'"
  source "$BREW_PREFIX/share/forgit/forgit.plugin.zsh"
  alias fgl='forgit::log'
  alias fgr='forgit::rebase'
  alias fgd='forgit::diff'
  alias fgb='forgit::blame'
fi

# tmuxinator
if command -v tmuxinator &>/dev/null; then
  alias mux='tmuxinator'
fi

# smart dot - run ./start if exists, otherwise source
.() {
  if [[ $# -eq 0 && -x ./start ]]; then
    ./start
  else
    builtin source "$@"
  fi
}

# system specific config
[ -s "$HOME/.zshrc" ] && source "$HOME/.zshrc"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# google cloud sdk
[ -s "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[ -s "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
