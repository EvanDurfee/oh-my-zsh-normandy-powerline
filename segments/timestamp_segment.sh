__normandy_pl_timestamp_seg () {
	local TIMESTAMP_FG="90"
	echo -n "\001\e[${TIMESTAMP_FG}m\002$(date '+%F %T')"
}
