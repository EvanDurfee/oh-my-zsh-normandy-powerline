__normandy_pl_dirname () {
	# variation on dirname that returns the last element of a path
	# eg '~/foo/bar' -> 'bar', and '~' -> '~'
	echo -n $1 | sed -E "s#^.*/##"
}

__normandy_pl_basename () {
	# variation on basename that returns the path preceding the final entry, or nothing
	# eg '~/foo/bar' -> '~/foo/', and '~' -> ''
	echo -n $1 | sed -E "s#[^/]+\$##"
}

__normandy_pl_swap_home () {
	# replaces $HOME in a path with ~
	echo -n $1 | sed -E "s#^$HOME($|(/))#~\2#"
}

__normandy_pl_shorten_path_ellipses () {
	# swaps all but the last ($2 + 1) path elements defined as (/.+) with ellipses
	# local ELLIPSES_GLYPH="..."
	local ELLIPSES_GLYPH="\u2026" # …
	local SHORTENED=$(echo -n $1 | sed -E "s#^.*(/([^/]+/){$2}[^/]+)\$#\1#")
	if [ "$SHORTENED" = "$1" ]; then : ; else
		local SHORTENED="$ELLIPSES_GLYPH$SHORTENED"
	fi
	echo -n $SHORTENED
}

__normandy_pl_git_dir () {
	# path to the git root or nothing if not in a git tree
	git rev-parse --show-toplevel 2>/dev/null
}

__normandy_pl_git_ref () {
	# current branch or ref (master if the repo is empty) Retuns nothing (and non-zero return code) if the head is detached
	git symbolic-ref --short HEAD 2>/dev/null
}

__normandy_pl_git_short_hash () {
	# short hash of the current commit
	git rev-parse --short HEAD 2>/dev/null
}

__normandy_pl_git_has_upstream () {
	# upstream commit if one exists, else nothing
	git rev-parse ${upstream} 2>/dev/null
}

__normandy_pl_git_commits_ahead () {
	# commits ahead of upstream for head
	git rev-list --count @{upstream}..HEAD
}

__normandy_pl_git_commits_behind () {
	# commits behind upstream for head
	git rev-list --count HEAD..@{upstream}
}

__normandy_pl_git_refresh () {
	git update-index -q --ignore-submodules --refresh
}

__normandy_pl_git_uncommited_changes_in_index () {
	# changes are staged but not commited
	git diff-index --cached --quiet HEAD --ignore-submodules --
	echo $?
}

__normandy_pl_git_changes_in_working_tree () {
	# changes have been made to tracked files but are not staged
	git diff-files --quiet --ignore-submodules --
	echo $?
}

__normandy_pl_git_untracked_files () {
	# the number of untracked non-ignored files
	git ls-files --exclude-standard --others $(__normandy_pl_git_dir) | wc -l
}
