#!/bin/sh

set -eu

log() {
	printf '[install] %s\n' "$1"
}

[ "${SHELL##/*/}" != "zsh" ] && echo 'You might need to change default shell to zsh: `chsh -s /bin/zsh`'
dev="$HOME/dev"
log "Creating dev directory: $dev"
mkdir -p $dev && cd $dev
log "Cloning dotfiles repo"
git clone --filter=blob:none --depth 1 --recurse-submodules --shallow-submodules https://github.com/andriictkn/dotfiles.git
cd dotfiles
log "Running symlink script"
sh etc/symlink-dotfiles.sh

log "Starting Homebrew install"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
log "Finished Homebrew install"

log "Loading Homebrew into current shell"
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
	eval "$(/usr/local/bin/brew shellenv)"
fi

command -v brew >/dev/null 2>&1 || {
	log "Homebrew installation did not complete successfully"
	exit 1
}

log "Installing node via brew"
brew install node
log "Finished installing node"

log "Starting nvm install"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
log "Finished nvm install"

log "Starting sdkman install"
curl -s "https://get.sdkman.io" | bash
log "Finished sdkman install"

# Optional: remove .git directories
# rm -rf .git vim/.git terminal/completion/.git terminal/highlight/.git terminal/autosuggestions/.git .gitmodules
# Optional: remove scripts
# rm install.sh etc/symlink-dotfiles.sh README.md
