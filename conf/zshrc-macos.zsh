# 1. PATH CONFIGURATION (Must come first!)
# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Define PATHs before loading plugins so they can find the tools
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# 2. INIT TOOLS (Env Setup)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
if command -v rbenv >/dev/null; then eval "$(rbenv init -)"; fi


# 3. OH-MY-ZSH CONFIG
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="" # Disabled because Starship handles it

# Plugins
plugins=(git rsync cp extract zoxide fzf zsh-autosuggestions zsh-syntax-highlighting brew gh ansible docker docker-compose laravel composer rails ruby python pip node npm bun golang rust macos)

source $ZSH/oh-my-zsh.sh


# 4. STARSHIP & ZOXIDE
if command -v zoxide >/dev/null; then eval "$(zoxide init zsh)"; fi
if command -v starship >/dev/null; then eval "$(starship init zsh)"; fi


# 5. ALIASES
alias zconfig="nano ~/.zshrc"
alias reload="source ~/.zshrc"
alias update="brew update && brew upgrade"
alias d="docker"
alias dc="docker compose"
alias art="php artisan"
alias brewup="brew update && brew upgrade && brew cleanup"
