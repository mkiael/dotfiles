is_in_hg_repo() {
   hg branch > /dev/null 2>&1
}

hg-file() {
  is_in_hg_repo || return
  hg status re: |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(hg diff --color always --git {-1} | sed 1,3d; cat {-1}) | head -500' |
  cut -c3-
}

hg-branch() {
  is_in_hg_repo || return

 (
  #hg branches --color always --pager never &
  hg bookmark -T '{pad(bookmark, 30)} {rev}:{node|short}\n'
  #hg bookmark -q --color always --pager never | sed '/no bookmarks set/d' &
  hg log -r 'remotebranches()' --template '{pad(remotebranches, 30)} {rev}:{node|short}\n'
 ) | sort |
 fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'hg log --color always -f -r "$(sed -e "s#^\(.\+[[:alnum:]]\)\s\+\([0-9]\+\):.*#\"\1\"#" <<< {})" | head -'$LINES |
  sed -e 's#^\(.\+[[:alnum:]]\)\s\+\([0-9]\+\):.*#\1#'
}

hg-history() {
   hg log --template '{date|shortdate} | {label("changeset.{phase}", rev)} | {desc|strip|firstline}\n' -G | \
   grep -v '^$' | \
   fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' --header 'Press CTRL-S to toggle sort' \
      --preview 'grep -o -P "(?<=\| )[0-9]+(?= \|)" <<< {} | cat | xargs -r hg log --color always --git -pvr | head -500' | \
   grep -o -P "(?<=\| )[0-9]+(?= \|)"
}
