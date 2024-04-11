function git-begin
  read -P "prefix[fix]: " prefix
  if test -z "$prefix"
    set prefix "fix"
  end
  read -P "Jira: " jira
  read -P "slug: " slug
  read -P "title[$slug]: " title
  if test -z "$title"
    set title $slug
  end

  set b "$prefix/$jira-$slug"
  set t "$jira $title"

  set c (git branch --show-current)
  git switch -c $b
  git commit --allow-empty -m "$t"
  git push --set-upstream origin $b
  gh pr create -a @me --draft --base $c -t "$t" -b "$jira" $ARGV
  gh pr view --json url -q.url | xargs $BROWSER
end
