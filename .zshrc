# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Plugins
zcomet load romkatv/powerlevel10k
zcomet load ohmyzsh plugins/nvm
zcomet load jeffreytse/zsh-vi-mode
zcomet load ohmyzsh plugins/gitfast

# Defered Plugins
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions

zcomet compinit

eval "$(zoxide init zsh)"

# Theme Stuff
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

DISABLE_UNTRACKED_FILES_DIRTY="true"

# User configuration
source $HOME/.local/bin/zsh/vi_mode
export PATH=/Users/charlieplate/.local/bin:$PATH
export PATH=/Users/charlieplate/.local/share/bob/nvim-bin:$PATH
export EDITOR='nvim'

alias zshrc="nvim ~/.zshrc"
alias ebs-ssh="ssh -L 1521:localhost:1521  opc@ebsoci.projectgraphite.com"
alias gtmux="sh ~/Documents/work/util/publicapi.sh"
alias killGraphite="sh ~/Documents/work/util/killGraphite.sh"
alias k="sh ~/Documents/work/util/killGraphiteProcess.sh"
alias vim="nvim"

alias ly='lazygit -ucd ~/.local/share/yadm/lazygit -w ~ -g ~/.local/share/yadm/repo.git'

export EDITOR=nvim

#GRAPHITE STUFF
export G_AUTO_WARM_UP=false
export GOOGLE_APPLICATION_CREDENTIALS="/Users/charlieplate/Documents/work/graphite/dev-env/savvy-eye-219502-ff128deb3183.json"
export JWT_TTL=1440
export LOG_LEVEL="trace"
# export EXTERNAL_INTERFACE_POLLING_ENABLED=true
export SFTP_ADMIN_PRIVATE_KEY=$(cat /Users/charlieplate/.ssh/sftp_admin_nonprod)
export SFTP_PGP_PRIVATE_KEY=$(cat /Users/charlieplate/Documents/work/util/keys/pgpPrivateKey)
# export SENDGRID_DEV_TO="charlie+garbage@graphiteconnect.com"

#node stuff
nvm use --silent 20
export PATH="/Users/charlieplate/.nvm/versions/node/v20.9.0/lib/node_modules/:$PATH"
export PATH="$(yarn global bin):$PATH"
# pnpm
export PNPM_HOME="/Users/charlieplate/Library/pnpm"

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun completions
[ -s "/Users/charlieplate/.bun/_bun" ] && source "/Users/charlieplate/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# nvim
export NVIM_WORK_DIR="/Users/charlieplate/Documents/work/graphite"

# python
PATH=$(pyenv root)/shims:$PATH

source "$HOME/.zsh_private_env"

