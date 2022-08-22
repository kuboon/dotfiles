#!/usr/bin/env bash
set -ue


apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends fish
chsh -s /usr/bin/fish vscode

# http://asdf-vm.com/guide/getting-started.html#_3-install-asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
echo "source ~/.asdf/asdf.fish" >> $HOME/.config/fish/config.fish

# RUN asdf plugin add deno && asdf install deno latest && asdf global deno latest
# RUN asdf plugin add golang && asdf install golang latest && asdf global golang latest
# RUN asdf plugin add rust && asdf install rust latest && asdf global rust latest

asdf plugin add nodejs
asdf plugin add rust
asdf plugin add deno
