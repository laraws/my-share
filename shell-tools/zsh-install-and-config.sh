#!/bin/bash

# install zsh

sudo apt update && apt install wget curl git zsh -y

# set zsh as default shell

sudo chsh -s /bin/zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install useful plugins
cd "$ZSH_CUSTOM/plugins"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git

# load useful plugins
sed -i -E "s/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g"  ~/.zshrc.bak

# fix zsh-autosuggestions slow issue
cat << 'ADDCONTENT'
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
ADDCONTENT
