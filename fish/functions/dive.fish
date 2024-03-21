function dive
  set repo $argv[1]
  if test -z (echo $repo | cut -d '/' -f3)
    set repo github.com/$repo
  end
  set path ~/repos/$repo

  if test -d $path
    cd $path
    echo "Moved to existing directory $path"
  else
    mkdir -p $path
    cd $path
    git clone https://$repo.git .
    echo "Cloned $repo and moved to directory $path"
  end
end
