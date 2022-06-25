# Standard
alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"

# Exa: Replace `ls`
if [ -x "$(command -v exa)" ]; then
    alias ls="exa --icons"
    alias lsl="exa -l"
    alias lsa="exa -a --icons"
fi

# Data Feeds
alias weather="curl http://v2.wttr.in/${WEATHER_CITY}"

# Docker Shortcuts
if [ -x "$(command -v docker)" ]; then
  alias dalpine="docker run --rm -it -v $(pwd):/shared alpine:latest"
  alias dubuntu="docker run --rm -it -v $(pwd):/shared ubuntu:latest"
  alias dnginx="docker run --rm -it -v $(pwd):/usr/share/nginx/html:ro -p 8080:80 nginx"
fi
