#!/usr/bin/env bash
set -ue

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update
DEBIAN_FRONTEND=noninteractive sudo apt-get -y install --no-install-recommends fish gh
sudo chsh -s /usr/bin/fish $USER

# http://asdf-vm.com/guide/getting-started.html#_3-install-asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
mkdir -p ~/.config/fish/completions; ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
echo "source ~/.asdf/asdf.fish" >> $HOME/.config/fish/config.fish

source ~/.asdf/asdf.sh
asdf plugin add nodejs
asdf plugin add golang
asdf install golang latest; asdf global golang latest
asdf plugin add rust
# asdf install rust latest && asdf global rust latest
asdf plugin add deno
# asdf install deno latest && asdf global deno latest

go install github.com/jesseduffield/lazygit@latest
