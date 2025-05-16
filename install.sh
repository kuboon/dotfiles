#!/usr/bin/env bash
set -ue

(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \

if grep -q "bullseye" /etc/os-release; then
  echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:4.list
  curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:4/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_4.gpg > /dev/null
fi
if grep -q "bookworm" /etc/os-release; then
  echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:4.list
  curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:4/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_4.gpg > /dev/null
fi

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

git config --global user.name "Ohkubo KOHEI";
git config --global gpg.format ssh
git config --global user.signingkey "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICHoDCdQytihD5c8WkXQrjPis4+ixYhy9T0BQseTOL/M"
git config --global commit.gpgsign true

git config --global alias.sw switch
git config --global alias.pushtag "!f(){ git tag -a -f \$1 -m\"\$2\"; git push -f origin \$1 ; }; f"

# https://blog.gitbutler.com/how-git-core-devs-configure-git/
git config --global column.ui auto
git config --global branch.sort -committerdate
git config --global tag.sort version:refname
git config --global init.defaultBranch main
git config --global diff.algorithm histogram
git config --global diff.colorMoved plain
git config --global diff.mnemonicPrefix true
git config --global diff.renames true
git config --global push.default simple
git config --global push.autoSetupRemote true
git config --global push.followTags true
git config --global fetch.prune true
git config --global fetch.pruneTags true
git config --global fetch.all true
git config --global help.autocorrect prompt
git config --global commit.verbose true
git config --global rerere.enabled true
git config --global rerere.autoupdate true
git config --global core.excludesfile ~/.gitignore
git config --global rebase.autoSquash true
git config --global rebase.autoStash true
git config --global rebase.updateRefs true

git config --global merge.conflictstyle zdiff3
# git config --global core.fsmonitor true
# git config --global core.untrackedCache true
git config --global pull.rebase true