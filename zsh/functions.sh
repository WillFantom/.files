
# Check if dotfiles update availiable and apply
function update.files() {
  
  if [[ ! -d ${HOME}/.files ]]; then 
    echo -e "No local copy of dotfiles found at ${HOME}/.files"
    return 1
  fi
  curr=$(pwd)
  cd ${HOME}/.files
  if [[ ! -d .git ]]; then 
    echo -e "The local .files directory is not a git repository"
    cd $curr
    return 1
  fi
  hash=$(git log -n 1 --pretty=format:"%H")
  if [ ! -n "$hash" ]; then
    echo -e "Latest local commit hash could not be found"
    cd $curr
    return 1
  fi
  remote_hash=$(curl -f -s https://api.github.com/repos/willfantom/.files/commits/main | jq -r .sha)
  if [ ! -n "$remote_hash" ]; then
    echo -e "Latest remote commit hash could not be found"
    cd $curr
    return 1
  fi
  echo -e "Latest Commits:"
  echo -e "\tLocal: "$hash
  echo -e "\tRemote: "$remote_hash
  if [[ "$hash" == "$remote_hash" ]]; then
    echo -e "You are already using the lastest version"
    cd $curr
    return 0
  fi
  echo -e "Updating..."
  git pull origin main
  ./install.sh -l $(pwd)
  echo -e "Done"
  cd $curr
}