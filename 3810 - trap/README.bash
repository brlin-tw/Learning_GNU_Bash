#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o errtrace
set -o pipefail

init(){
	a_long_running_function
	inexist_command
	exit 0
}

a_long_running_function(){
	echo "${FUNCNAME[0]} called"
	sleep 5
}; declare -ft a_long_running_function

trap_exit(){
	echo "EXIT trap is triggered."
	return 0
}

trap_debug(){
	for ignored_function in\
		trap_exit\
		trap_err\
		trap_return\
		echo
		do
		if [ "${BASH_COMMAND%% *}" == "${ignored_function}" ]; then
			return 0
		fi
	done

	echo "DEBUG trap is triggered, before $BASH_COMMAND is called."
	return 0
}

trap_err(){
	echo "ERR trap is triggered, errored command is $BASH_COMMAND with exit status $?"
	return 0
}

trap_return(){
	echo "RETURN trap is triggered, returning from ${FUNCNAME[1]}"
}

trap_int(){
	echo "INT trap is triggered."
}

trap trap_exit EXIT
trap trap_err ERR
trap trap_return RETURN
trap trap_int INT
trap trap_debug DEBUG
init
