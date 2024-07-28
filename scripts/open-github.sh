open "https://$(git config --get remote.origin.url | sed 's/git@//g' | sed 's/:/\//g' | sed 's/.git//g')"
