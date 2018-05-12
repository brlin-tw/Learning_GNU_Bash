# shellcheck shell=bash

# Makes debuggers' life easier
# 林博仁 <Buo.Ren.Lin@gmail.com> © 2017
## Exit when any command fails without being properly handled
set -o errexit

## Exit when unset variable being referenced
set -o nounset

## If set, any trap on `ERR' is inherited by shell functions, command substitutions, and commands executed in a subshell environment.  The `ERR' trap is normally not inherited in such cases.
set -o errtrace

## Trigger trap if program prematurely exited due to an error, collect all information useful to debug
trap_warn_before_errexit_abort(){
	local -ir line_error_location=${1}; shift # The line number that triggers the error
	local -r failing_command="${1}"; shift # The failing command
	local -ir failing_command_return_status=${1} # The failing command's return value

	printf 'ERROR: This program has encountered an error and is ending prematurely, contact developer for support.\n' 1>&2

	printf '\n' # Separate paragraphs

	printf 'Technical information:\n'
	printf '\n' # Separate list title and items
	printf '	* The error happens at line %s\n' "${line_error_location}"
	printf '	* The failing command is "%s"\n' "${failing_command}"
	printf "	* Failing command's return status is %s\\n" "${failing_command_return_status}"
	printf '	* Intepreter info: GNU Bash v%s on %s platform\n' "${BASH_VERSION}" "${MACHTYPE}"
	printf '\n' # Separate list and further content

	printf 'Goodbye.\n'
	return
}
trap 'trap_warn_before_errexit_abort ${LINENO} "${BASH_COMMAND}" ${?}' ERR
