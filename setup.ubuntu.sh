#!/bin/bash
sudo apt update
sudo apt install -y \
    curl \
    git \
    tmux \
    xclip \
    zsh \
    unzip

sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

sudo apt install -y \
    python3 \
    pip \
    golang-go

sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

rm  -rf ~/.oh-my-zsh

touch ~/.zshrc && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

cp -r zsh/custom/* ~/.oh-my-zsh/custom/
cp zsh/.p10k.zsh ~/.p10k.zsh
cp zsh/.zshrc ~/.zshrc

source ~/.zshrc && nvm install --lts

cp tmux/tmux.conf ~/.tmux.conf

# Install custom lazyvim
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvi
git clone https://github.com/empty21/lazyvim ~/.config/nvim

cp Taskfile.yaml ~/

sudo chsh -s $(which zsh)

echo "export PATH=$PATH:$HOME/.local/bin:$HOME/go/bin:/opt/nvim-linux64/bin" >> ~/.zshrc
zsh && source ~/.zshrc
