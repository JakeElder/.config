# set xdg dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# set fzf defaults
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob !.git'

# set editor
export EDITOR='nvim'

# show colors in ls and grep
alias ls='ls -G'
alias grep='grep --color=auto --exclude-dir={.git}'

# pretty cat files
alias cat='bat'

# alias vim to neovim
alias vim='nvim'

# alias mux to tmuxinator
alias mux='tmuxinator'

# project aliases
alias ms-web="cd '${HOME}/Projects/Mindful Studio/Code/ms-web' && ./start"

# set a custom prompt
prompt_color=$(case "$MACHINE_ID" in
  "jwserver") echo magenta;;
  *) echo blue;;
esac)
PROMPT="%2~ %F{${prompt_color}}>%f "

# set up history
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# set session and histfile location
SHELL_SESSION_DIR="${XDG_DATA_HOME}/zsh/zsh_sessions"
HISTFILE="${XDG_DATA_HOME}/zsh/zsh_history"

# use vim bindings
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^[[Z' reverse-menu-complete

# set up tab completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"
zstyle ':completion:*' menu select

# enable tab completions
autoload -Uz compinit
compinit -d "${XDG_DATA_HOME}/zsh/zcompdump"

# load direnv
eval "$(direnv hook zsh)"

# set u pet
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^n' pet-select

# enable esc v to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# set up zplug
if [[ "$(uname)" == "Darwin" ]]; then
  export ZPLUG_HOME=$(brew --prefix)/opt/zplug
else
  export ZPLUG_HOME="${HOME}/.zplug"
fi
source "${ZPLUG_HOME}/init.zsh"

# add plugins
zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2
zplug "lukechilds/zsh-nvm"

# load zplug
zplug load

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

if [ -d "$HOME/Library/Python/3.10/bin/" ] ; then
    PATH="$HOME/Library/Python/3.10/bin/:$PATH"
fi
