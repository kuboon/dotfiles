#!/usr/bin/env fish
fish_add_path ~/dotfiles/bin

# https://unix.stackexchange.com/a/631801
function add_history_entry
  begin
    flock 1
    and echo -- '- cmd:' (
      string replace -- \n \\n (string join ' ' $argv) | string replace \\ \\\\
    )
    and date +'  when: %s'
  end >> $__fish_user_data_dir/fish_history
  and history merge
end

add_history_entry 'git fetch -ptf'
add_history_entry 'gh pr view --json url -q.url'

mkdir -p ~/.config/fish/functions
cp ./fish/functions/* ~/.config/fish/functions
