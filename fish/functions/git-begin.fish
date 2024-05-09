function git-begin
  read -P "prefix[fix]: " prefix
  if test -z "$prefix"
    set prefix "fix"
  end
  read -P "Ticket: " ticket
  read -P "slug: " slug
  read -P "title[$slug]: " title
  if test -z "$title"
    set title $slug
  end

  set b "$prefix/$ticket-$slug"
  set title "$ticket $title"

  set base (git branch --show-current)
  set basepr (gh pr view --json number -q.number 2>/dev/null)
  if test -z "$basepr"
    set body "$ticket"
  else
    set body "$ticket\nbase: #$basepr"
  end

  git switch -c $b
  git commit --allow-empty -m "$title"
  git push --set-upstream origin $b
  gh pr create -a @me --draft --base $base -t "$title" -b "$body" $argv
  gh pr view --json url -q.url | xargs $BROWSER
end
