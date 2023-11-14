#!/usr/bin/env zsh

# Standard
alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"

# Replace `ls` with `exa` for nicer formatting with icons and colors...
alias ls="run_alternative ls eza https://github.com/eza-community/eza -lah --icons -F --hyperlink"
alias lsl="run_alternative ls eza https://github.com/eza-community/eza -l --icons -F --hyperlink"
alias lsa="run_alternative ls eza https://github.com/eza-community/eza -a --icons -F --hyperlink"
alias lsla="run_alternative ls eza https://github.com/eza-community/eza -a -l --icons -F --hyperlink"

# Replace 'cat' with 'bat' for nicer formatting with colors, line numbers etc...
alias cat="run_alternative cat bat https://github.com/sharkdp/bat"

# Replace 'htop' and 'gotop' with 'btm' for nicer graph output...
alias htop="run_alternative htop btm https://github.com/ClementTsang/bottom"
alias gotop="run_alternative gotop btm https://github.com/ClementTsang/bottom"

# Terminal utility shortcuts:
alias weather='curl http://v2.wttr.in/"${WEATHER_CITY}"'

# Duck Duck Gor Shortuts
if [ -x "$(command -v ddgr)" ]; then
  alias ddg="ddgr --reg en-gb --unsafe --noprompt"
  alias ddgp="ddgr --reg en-gb --unsafe"
fi

# Docker Shortcuts
if [ -x "$(command -v docker)" ]; then
  alias dalpine='docker run --rm -it -v "$(pwd)":/shared alpine:latest'
  alias dubuntu='docker run --rm -it -v "$(pwd)":/shared ubuntu:latest'
  alias dnginx='docker run --rm -it -v "$(pwd)":/usr/share/nginx/html:ro -p 8080:80 nginx'
fi

# Github Copilot Shortcuts
if [ -x "$(command -v gh)" ]; then
  alias copilot='gh copilot suggest -t shell "$@"'
  alias ghc='gh copilot suggest -t shell "$@"'
fi