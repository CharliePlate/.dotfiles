# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="af-magic"
# ZSH_THEME="half-life"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-nvm zsh-vi-mode)
source $ZSH/oh-my-zsh.sh


# User configuration
source $HOME/.local/bin/zsh/vi_mode

# Load Autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

export PATH=/Users/charlieplate/.local/bin:$PATH
export PATH=/Users/charlieplate/.local/share/bob/nvim-bin:$PATH
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias zshrc="nvim ~/.zshrc"
alias ebs-ssh="ssh -L 1521:localhost:1521  opc@ebsoci.projectgraphite.com"
alias gtmux="sh ~/Documents/work/util/publicapi.sh"
alias killGraphite="sh ~/Documents/work/util/killGraphite.sh"
alias k="sh ~/Documents/work/util/killGraphiteProcess.sh"
alias vim="nvim"
alias gcc="gcc-13"

alias ly='lazygit -ucd ~/.local/share/yadm/lazygit -w ~ -g ~/.local/share/yadm/repo.git'


export EDITOR=nvim
eval "$(starship init zsh)"

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
# pnpm end

# bun completions
[ -s "/Users/charlieplate/.bun/_bun" ] && source "/Users/charlieplate/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# nvim
export NVIM_WORK_DIR="/Users/charlieplate/Documents/work/graphite"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

PATH=$(pyenv root)/shims:$PATH

source "$HOME/.zsh_private_env"
