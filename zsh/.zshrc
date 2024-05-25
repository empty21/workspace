export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Source all custom files in the custom directory
for file in $ZSH/custom/*.zsh; do
  source $file
done

source $ZSH/oh-my-zsh.sh
source $HOME/.p10k.zsh