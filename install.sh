#!/bin/sh

[ "${SHELL##/*/}" != "zsh" ] && echo 'You might need to change default shell to zsh: `chsh -s /bin/zsh`'
dev="$HOME/dev"
mkdir -p $dev && cd $dev
git clone --filter=blob:none --depth 1 --recurse-submodules --shallow-submodules https://github.com/andriictkn/dotfiles.git
cd dotfiles
sh etc/symlink-dotfiles.sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install node

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

curl -s "https://get.sdkman.io" | bash

# Optional: remove .git directories
# rm -rf .git vim/.git terminal/completion/.git terminal/highlight/.git terminal/autosuggestions/.git .gitmodules
# Optional: remove scripts
# rm install.sh etc/symlink-dotfiles.sh README.md
