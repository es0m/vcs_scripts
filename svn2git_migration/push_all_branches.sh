#git branch -a | sed 's/remotes\///g' | awk '{print "git push gitlab remotes/"$1":refs/heads/"$1" --dry-run"}'
git tag -l | sed 's/-/\//' | awk '{print "git push gitlab remotes/tags/"$1":refs/heads/tags/"$1" "}'
