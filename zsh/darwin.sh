# 1Password SSH Auth Socket
if [[ -d /Applications/1Password.app ]]; then
  if [[ -e "~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock" ]]; then
    mkdir -p ~/.1password && ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
  fi
fi
