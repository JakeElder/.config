#!/usr/bin/env bash

source ~/.config/tc/.tc

env | grep ^TC_ | while read -r line; do
  name="${line%%=*}"
  value="${line#*=}"
  # TC_BASE -> @tc_base
  opt_name="@tc_$(echo "${name#TC_}" | tr '[:upper:]' '[:lower:]')"
  tmux set-option -g "$opt_name" "$value"
done
