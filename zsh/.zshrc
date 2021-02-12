# set XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# show colors in ls and grep
alias ls='ls -G'
alias grep='grep --color=auto --exclude-dir={.git}'

# alias vim to neovim
alias vim='nvim'

# set a custom prompt, ${short wd} >
PROMPT='%2~ %F{blue}>%f '

# set up history
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

HISTFILE="${XDG_DATA_HOME}/zsh/zsh_history"

# use vim bindings
bindkey -v
bindkey '^R' history-incremental-search-backward

# set up homebrew completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# set up tab completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"

# enable tab completions
autoload -Uz compinit
compinit -d "${XDG_DATA_HOME}/zsh/zcompdump"

# set session dir
SHELL_SESSION_DIR="${XDG_DATA_HOME}/zsh/zsh_sessions"
