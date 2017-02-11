# Makes debuggers' life easier
# 林博仁 <Buo.Ren.Lin@gmail.com> © 2017
## Exit when any command fails without being properly handled
set -o errexit

## Exit when unset variable being referenced
set -o nounset

## If set, any trap on `ERR' is inherited by shell functions, command substitutions, and commands executed in a subshell environment.  The `ERR' trap is normally not inherited in such cases.
set -o errtrace

## Trigger trap if program prematurely exited due to an error, collect all information useful to debug
bash_commons_meta_warn_before_errexit_abort(){
	local -ir line_error_location=${1}; shift # The line number that triggers the error
	local -ir command_return_status=${1} # The command return value that triggers the error

	printf "ERROR: This program has encountered an error and is ending prematurely, contact developer for support.\n" 1>&2

	printf "\n" # Separate paragraphs

	printf "INFO: Technical information:\n"
	printf "\n" # Separate list title and items
	printf "INFO: * The error happens at line %s\n" "${line_error_location}"
	printf "INFO: * Last command return status is %s\n" "${command_return_status}"
	printf "INFO: * Intepreter info: GNU Bash v%s on %s platform\n" "${BASH_VERSION}" "${MACHTYPE}"
	return
}
trap 'bash_commons_meta_warn_before_errexit_abort ${LINENO} ${?}' ERR
