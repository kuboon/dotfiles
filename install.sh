#!/usr/bin/env bash
set -ue

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update
DEBIAN_FRONTEND=noninteractive sudo apt-get -y install --no-install-recommends fish gh

sudo chsh -s /usr/bin/fish $USER
fish ./setup.fish

# https://mise.jdx.dev/getting-started.html
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate --shims bash)"' >> ~/.bashrc
echo '~/.local/bin/mise activate --shims fish | source' >> ~/.config/fish/config.fish

~/.local/bin/mise u -gy lazygit

mkdir -p ~/.ssh
echo "github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl" >> ~/.ssh/known_hosts

git config --global alias.sw switch
git config --global alias.pushtag "!f(){ git tag -a -f \$1 -m\"\$2\"; git push -f origin \$1 ; }; f"
