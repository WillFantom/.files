#!/bin/bash
set -e

echo "Installing Fantom's DotFiles..."

# Parse CLI options
local_path=""
while getopts "l:" o; do
    case "${o}" in
        l)
            local_path=${OPTARG}
            ;;
    esac
done

# Utility functions
function link_file() {
  if [[ -L $2 ]]; then
    if [ "$(readlink -- "$2")" != $1 ]; then
      echo -e "removing preexisting non-compatible symlink"
      echo -e "\tlink: "$2
      echo -e "\tcurrent target: "$(readlink -- "$2")
      echo -e "\tnew target: "$1
      rm $2
    else
      return 0
    fi
  elif [[ -f $2 ]]; then
    echo -e "removing old file"
    echo -e "\tfile: "$2
    echo -e "\tbacking up to: "${backup_dir}/$1
    mkdir -p $(dirname ${backup_dir}/$1)
    mv $2 ${backup_dir}/$1
  fi
  ln -s $1 $2
}

# Setup Backup
backup_dir=~/.files_backup
mkdir -p ${backup_dir}

# Setup Dotfiles Dir
dotfiles_dir=~/.files
mkdir -p ${dotfiles_dir}
if [[ $local_path == "" ]]; then
  git clone https://github.com/willfantom/.files ${dotfiles_dir}
else
  cp -R ${local_path}/* ${dotfiles_dir}/
fi
cd ${dotfiles_dir}

# Link zshrc
link_file $(pwd)/zsh/zshrc ~/.zshrc

# Link git configuration
link_file $(pwd)/git/gitconfig ~/.gitconfig
link_file $(pwd)/git/gitcommit ~/.gitcommit
link_file $(pwd)/git/gitignoreglobal ~/.gitignoreglobal

# Link macchina themes
mkdir -p ~/.config/macchina/themes
link_file $(pwd)/macchina/themes/fantom-minimal.toml ~/.config/macchina/themes/fantom-minimal.toml
link_file $(pwd)/macchina/themes/fantom.toml ~/.config/macchina/themes/fantom.toml

if [ -t 0 ]; then
  read -p "Git || Enter your full name: " name
  git config --global user.name "$name"
  read -p "Git || Enter your email address: " email
  git config --global user.email "$email"
  read -p "Setup SSH Signing? (y/n)" -n 1 -r
  echo -e ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Git || Enter your ssh signing key (public): " key
    git config --global user.signingkey "$key"
    git config --global gpg.format ssh
  fi
else
  echo "echo \"Warning: Git Credentials not set by dotfiles install script\"" >> $(pwd)/zsh/zshrc
fi

rm ~/.zcompdump* > /dev/null
source ~/.zshrc
