#!/usr/bin/env bash
source "../0000 - Commons/Enable strict mode.source.bash"

declare -ar commandline_argument_list_at=("${@}")
declare -ir commandline_argument_quantity=${#}

if [ "${commandline_argument_quantity}" -eq 0 ];then
	printf "Script has no command-line argument.\n"
else
	declare -i counter
	for ((counter = 0; counter < commandline_argument_quantity; ++counter)); do
		printf "Command-line argument #%d: %s\n" "${counter}" "${commandline_argument_list_at[${counter}]}"
	done
fi

exit 0