if [[ "$(uname)" == "Darwin" ]]; then
  # set up brew with completion
  eval $(brew shellenv)
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
