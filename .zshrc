# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

addToPath() {
  if [[ "$PATH" != *"$1"* ]]; then
    export PATH=$PATH:$1
  fi
}

addToPathFront() {
  if [[ "$PATH" != *"$1"* ]]; then
    export PATH=$1:$PATH
  fi
}

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

export GOPATH=$HOME/go

export GOBIN=$GOPATH/bin
export GOARCH=arm64  # для M1/M2
export GOOS=darwin

addToPathFront "/opt/homebrew/opt/libpq/bin"
addToPath "/usr/local/go/bin"
addToPath "$GOPATH/bin"
addToPath "$HOME/.cargo/bin"
addToPath $PATH:$GOBIN
addToPath "$HOME/.local/scripts"

export KUBECONFIG=$HOME/.kube/config

export PIPENV_VENV_IN_PROJECT=True
export PIPENV_DEFAULT_PYTHON_VERSION=3.11
# export PIP_CERT=/etc/ssl/certs/ca-certificates.crt
# export SSL_CERT_FILE=${CERT_PATH}
export REQUESTS_CA_BUNDLE=${CERT_PATH}

source "$HOME/.rye/env"
ZSH_THEME="af-magic"

zstyle ':omz:update' mode auto      # update automatically without asking
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
	z
	gh
	gitignore
	pip
	postgres
	python
	redis-cli
	brew
	tmux
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias vim=nvim
alias vi=nvim
alias aider="python -m aider"
alias ll='eza --icons=always -1 --group-directories-first'
alias fvim='vim $(fzf --preview "bat --style=numbers --color=always --line-range :500 {}")'


source <(fzf --zsh)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

function load-token {
    local token_name="$1"   # Название токена (например, "Anthropic API key")
    local pass_path="$2"    # Путь в pass (например, "anthropic/api-key")

    # Проверяем наличие записи в pass
    if ! pass show "$pass_path" &> /dev/null; then
        echo -e "\033[31mError: $token_name ($pass_path) is not in the password store.\033[0m"  # Красный текст для ошибки
    else
        export "$token_name"=$(pass show "$pass_path")
        echo -e "\033[32m$token_name successfully loaded from $pass_path.\033[0m"  # Зеленый текст для успеха
    fi
}

load-ai() {
  load-token ANTHROPIC_API_KEY anthropic/api-key
  load-token OPENAI_API_KEY openai/api-key
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)

# Created by `pipx` on 2025-01-07 21:42:32
export PATH="$PATH:/Users/leo/.local/bin"
