function in_hg() {
   parent=$(pwd)
   while [[ "$parent" != "/" ]]; do
      if [[ -d "$parent/.hg" ]]; then
         echo 1
         break
      fi
      parent=`dirname $parent`
   done
}

function hg_get_branch_name() {
   parent=$(pwd)
   while [[ "$parent" != "/" ]]; do
      if [[ -d "$parent/.hg" ]]; then
         if [[ -f "$parent/.hg/bookmarks.current" ]]; then
            cat "$parent/.hg/bookmarks.current"
         else
            echo $(hg branch)
         fi
         break
      fi
      parent=`dirname $parent`
   done
}

function hg_prompt_info {
  if [[ $(in_hg) ]]; then
    _DISPLAY=$(hg_get_branch_name)
    echo "$ZSH_PROMPT_BASE_COLOR$ZSH_THEME_HG_PROMPT_PREFIX\
$ZSH_THEME_REPO_NAME_COLOR$_DISPLAY$ZSH_PROMPT_BASE_COLOR$ZSH_PROMPT_BASE_COLOR$(hg_dirty)$ZSH_THEME_HG_PROMPT_SUFFIX$ZSH_PROMPT_BASE_COLOR"
    unset _DISPLAY
  fi
}

function hg_dirty_choose {
   if [[ $(in_hg) ]]; then
      hg status 2> /dev/null | command grep -Eq '^\s*[ACDIM!?L]'
      if [ $pipestatus[-1] -eq 0 ]; then
         # Grep exits with 0 when "One or more lines were selected", return "dirty".
         echo $1
      else
         # Otherwise, no lines were found, or an error occurred. Return clean.
         echo $2
      fi
   fi
}

function hg_dirty {
   # disabled since hg status is quite slow (used in hg_dirty_choose)
   #hg_dirty_choose $ZSH_THEME_HG_PROMPT_DIRTY $ZSH_THEME_HG_PROMPT_CLEAN
   echo $ZSH_THEME_HG_PROMPT_CLEAN
}

function find-up () {
   p=$(pwd)
   while [[ "$p" != "" && ! -e "$p/$1" ]]; do
      p=${p%/*}
   done
   echo "$p"
}

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg_bold[blue]%}hg:(%{$fg[red]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg[blue]%})"
