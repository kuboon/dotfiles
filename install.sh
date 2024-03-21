#!/usr/bin/env bash
set -ue

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# debian 11 (bullseye)
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null

sudo apt update
DEBIAN_FRONTEND=noninteractive sudo apt-get -y install --no-install-recommends fish gh

sudo chsh -s /usr/bin/fish $USER
fish ./setup.fish

# https://mise.jdx.dev/getting-started.html
curl https://mise.jdx.dev/install.sh | sh
echo '~/.local/bin/mise activate fish | source' >> ~/.config/fish/config.fish

mise u -gy lazygit

git config --global user.email "kuboon@trick-with.net"
git config --global user.name "Ohkubo Kohei"
