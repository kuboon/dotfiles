#!/usr/bin/env bash
set -ue

sudo apt-get update
DEBIAN_FRONTEND=noninteractive sudo apt-get -y install --no-install-recommends fish
sudo chsh -s /usr/bin/fish $USER

# http://asdf-vm.com/guide/getting-started.html#_3-install-asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
mkdir -p ~/.config/fish/completions; ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
echo "source ~/.asdf/asdf.fish" >> $HOME/.config/fish/config.fish

source ~/.asdf/asdf.sh
asdf plugin add nodejs
asdf plugin add rust
# asdf install rust latest && asdf global rust latest
asdf plugin add deno
# asdf install deno latest && asdf global deno latest
