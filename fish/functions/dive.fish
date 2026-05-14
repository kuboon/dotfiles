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
    if git clone https://$repo.git .
      echo "Cloned $repo and moved to directory $path"
    else
      # git clone failed - likely repository not found
      echo ""
      read -P "create? [y/N] " -n 1 answer
      echo ""

      if test "$answer" = "y" -o "$answer" = "Y"
        # Extract owner and repo name from the repo path
        set repo_full (string replace 'github.com/' '' $repo)

        # Create repository using gh CLI
        echo "Creating repository $repo_full..."
        if gh repo create $repo_full --public
          # Initialize with empty commit
          git init
          git branch -M main
          git commit --allow-empty -m "Initial commit"
          git remote add origin https://$repo.git
          git push -u origin main
          echo "Created repository and pushed initial commit"
        else
          echo "Failed to create repository"
          cd -
          rm -rf $path
        end
      else
        echo "Cancelled."
        cd -
        rm -rf $path
      end
    end
  end
end
