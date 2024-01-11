#!/usr/bin/env bash
set -ue

sudo apt update
sudo apt install -y software-properties-common
sudo apt-add-repository -y ppa:fish-shell/release-3

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update
DEBIAN_FRONTEND=noninteractive sudo apt-get -y install --no-install-recommends fish gh

sudo chsh -s /usr/bin/fish $USER
fish ./setup.fish

# https://mise.jdx.dev/getting-started.html
curl https://mise.jdx.dev/install.sh | sh
echo '~/.local/bin/mise activate fish | source' >> ~/.config/fish/config.fish

mise u -g golang@latest
mise x -- go install github.com/jesseduffield/lazygit@latest
mise reshim
