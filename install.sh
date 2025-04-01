#!/usr/bin/env bash
set -ue

sudo apt update
DEBIAN_FRONTEND=noninteractive sudo apt upgrade && sudo apt-get -y install --no-install-recommends fish gh

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