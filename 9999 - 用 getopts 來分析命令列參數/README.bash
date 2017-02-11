#!/usr/bin/env bash
# 參考資料：GNU Bash infodoc 格式使用手冊/Bourne Shell Builtins
# 林博仁 <Buo.Ren.Lin@gmail.com> © 2016, 2017
source "../0000 - Commons/Enable strict mode.source.bash"

while getopts "dh" short_argument; do
	case "${short_argument}" in
		d)
			echo "-d found"
		;;
		h)
			echo "-h found"
		;;
		\?)
			echo "Invalid option: $OPTARG"
		;;
	esac
done
exit 0
