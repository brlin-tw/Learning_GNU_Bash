#!/usr/bin/env bash
# 參考資料：GNU Bash infodoc 格式使用手冊/Bourne Shell Builtins
# 林博仁 <Buo.Ren.Lin@gmail.com> © 2016, 2017
source "../9999 - Commons/Enable strict mode.source.bash"

printf "# getopts demonstration #\n"

printf "## Demonstrating Normal Mode(Not Implemented Yet) ##\n"

printf "\n"

printf "## Demonstrating Silent Mode ##\n"
while getopts ":dh" short_argument; do
	case "${short_argument}" in
		d)
			echo "-d found"
		;;
		h)
			echo "-h found"
		;;
		?)
			echo "Invalid option: $OPTARG"
		;;
	esac
done
exit 0
