#!/usr/bin/env bash
######## Included files ########

######## Included files ended ########

######## File scope variable definitions ########
# Defensive Bash Programming - not-overridable primitive definitions
# http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming/
readonly PROGRAM_FILENAME="$(basename "$0")"
readonly PROGRAM_DIRECTORY="$(realpath --no-symlinks "$(dirname "$0")")"
readonly PROGRAM_ARGUMENT_ORIGINAL_LIST="$@"
readonly PROGRAM_ARGUMENT_ORIGINAL_NUMBER=$#

## Unofficial Bash Script Mode
## http://redsymbol.net/articles/unofficial-bash-strict-mode/
# 將未定義的變數的參考視為錯誤
set -u

# Exit immediately if a pipeline, which may consist of a single simple command, a list, or a compound command returns a non-zero status.  The shell does not exit if the command that fails is part of the command list immediately following a `while' or `until' keyword, part of the test in an `if' statement, part of any command executed in a `&&' or `||' list except the command following the final `&&' or `||', any command in a pipeline but the last, or if the command's return status is being inverted with `!'.  If a compound command other than a subshell returns a non-zero status because a command failed while `-e' was being ignored, the shell does not exit.  A trap on `ERR', if set, is executed before the shell exits.
#FIXME: ERR handler not working...don't know why
exit_because_of_error() {
	printf "Error: program interrupted because of error.\n" 1>&2
	exit 1
}
trap exit_because_of_error ERR
set -e

# If set, the return value of a pipeline is the value of the last (rightmost) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail

######## File scope variable definitions ended ########

######## Program ########
# Defensive Bash Programming - main function, program entry point
# http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming/
main() {
	printf "# Detect Declared But Not Necessarily Set Variables #\n"
	set -x
	readonly variable_readonly_declared_but_not_set
	readonly variable_readonly_set_empty_string=""
	declare variable_declared_but_not_set
	declare variable_declared_set_empty_string=""
	printf "+ # variable_not_declared\n"; # variable_not_declared
	set +x
	
	printf "\n"
	
	printf "## Expectations ##\n"
	printf "\$variable_readonly_declared_but_not_set is declared.\n"
	printf "\$variable_readonly_set_empty_string is declared.\n"
	printf "\$variable_declared_but_not_set is declared.\n"
	printf "\$variable_declared_set_empty_string is declared.\n"
	printf "\$variable_not_declared is NOT declared.\n"
	printf "################\n"
	
	printf "\n"
	
	printf "## Reality ##\n"
	printf "##### Using Parameter Expansion \${PARAMETER:+WORD} #####\n"
	if [ -z "${variable_readonly_declared_but_not_set:+parameter_is_not_null_and_not_unset}" ]; then
		printf "\$variable_readonly_declared_but_not_set is null or unset.\n"
		else
		printf "\$variable_readonly_declared_but_not_set is NOT null and NOT unset.\n"
	fi
	if [ -z "${variable_readonly_set_empty_string:+parameter_is_not_null_and_not_unset}" ]; then
		printf "\$variable_readonly_set_empty_string is null or unset.\n"
		else
		printf "\$variable_readonly_set_empty_string is NOT null and NOT unset.\n"
	fi
	if [ -z "${variable_declared_but_not_set:+parameter_is_not_null_and_not_unset}" ]; then
		printf "\$variable_declared_but_not_set is null or unset.\n"
		else
		printf "\$variable_declared_but_not_set is NOT null and NOT unset.\n"
	fi
	if [ -z "${variable_declared_set_empty_string:+parameter_is_not_null_and_not_unset}" ]; then
		printf "\$variable_declared_set_empty_string is null or unset.\n"
		else
		printf "\$variable_declared_set_empty_string is NOT null and NOT unset.\n"
	fi
	if [ -z "${variable_not_declared:+parameter_is_not_null_and_not_unset}" ]; then
		printf "\$variable_not_declared is null or unset.\n"
		else
		printf "\$variable_not_declared is NOT null and NOT unset.\n"
	fi
	printf "#########################################################\n"
	
	printf "\n"
	
	printf "##### Using test -v #####\n"
	if [ -v variable_readonly_declared_but_not_set ]; then
		printf "\$variable_readonly_declared_but_not_set is set.\n"
		else
		printf "\$variable_readonly_declared_but_not_set is NOT set.\n"
	fi
	if [ -v variable_readonly_set_empty_string ]; then
		printf "\$variable_readonly_set_empty_string is set.\n"
		else
		printf "\$variable_readonly_set_empty_string is NOT set.\n"
	fi
	if [ -v variable_declared_but_not_set ]; then
		printf "\$variable_declared_but_not_set is set.\n"
		else
		printf "\$variable_declared_but_not_set is NOT set.\n"
	fi
	if [ -v variable_declared_set_empty_string ]; then
		printf "\$variable_declared_set_empty_string is set.\n"
		else
		printf "\$variable_declared_set_empty_string is NOT set.\n"
	fi
	if [ -v variable_not_declared ]; then
		printf "\$variable_not_declared is set.\n"
		else
		printf "\$variable_not_declared is NOT set.\n"
	fi
	printf "#########################\n"
	
	printf "\n"
	
	printf "##### Using [ -n \"\${var+_}\" ] from http://mywiki.wooledge.org/BashFAQ/083#Testing_that_a_variable_has_been_declared #####\n"
	if [ -n "${variable_readonly_declared_but_not_set+_}" ]; then
		printf "\$variable_readonly_declared_but_not_set is declared.\n"
		else
		printf "\$variable_readonly_declared_but_not_set is NOT declared.\n"
	fi
	if [ -n "${variable_readonly_set_empty_string+_}" ]; then
		printf "\$variable_readonly_set_empty_string is declared.\n"
		else
		printf "\$variable_readonly_set_empty_string is NOT declared\n"
	fi
	if [ -n "${variable_declared_but_not_set+_}" ]; then
		printf "\$variable_declared_but_not_set is declared.\n"
		else
		printf "\$variable_declared_but_not_set is NOT declared.\n"
	fi
	if [ -n "${variable_declared_set_empty_string+_}" ]; then
		printf "\$variable_declared_set_empty_string is declared.\n"
		else
		printf "\$variable_declared_set_empty_string is NOT declared.\n"
	fi
	if [ -n "${variable_not_declared+_}" ]; then
		printf "\$variable_not_declared is declared.\n"
		else
		printf "\$variable_not_declared is NOT declared.\n"
	fi
	printf "#########################################################################################################################\n"
	
	printf "\n"
	
	printf "##### Using \`declare -p 2>/dev/null | grep \"^declare.* VARIABLE(|=.*)$\" &>/dev/null\` #####\n"
	declare -p 2>/dev/null | grep --extended-regexp "^declare.* variable_readonly_declared_but_not_set(|=.*)$" &>/dev/null
	if [ $? -eq 0 ]; then
		printf "\$variable_readonly_declared_but_not_set is declared.\n"
		else
		printf "\$variable_readonly_declared_but_not_set is NOT declared.\n"
	fi
	declare -p 2>/dev/null | grep --extended-regexp "^declare.* variable_readonly_set_empty_string(|=.*)$" &>/dev/null
	if [ $? -eq 0 ]; then
		printf "\$variable_readonly_set_empty_string is declared.\n"
		else
		printf "\$variable_readonly_set_empty_string is NOT declared\n"
	fi
	declare -p 2>/dev/null | grep --extended-regexp "^declare.* variable_declared_but_not_set(|=.*)$" &>/dev/null
	if [ $? -eq 0 ]; then
		printf "\$variable_declared_but_not_set is declared.\n"
		else
		printf "\$variable_declared_but_not_set is NOT declared.\n"
	fi
	declare -p 2>/dev/null | grep --extended-regexp "^declare.* variable_declared_set_empty_string(|=.*)$" &>/dev/null
	if [ $? -eq 0 ]; then
		printf "\$variable_declared_set_empty_string is declared.\n"
		else
		printf "\$variable_declared_set_empty_string is NOT declared.\n"
	fi
	
	set +e
	
	declare -p 2>/dev/null | grep --extended-regexp "^declare.* variable_not_declared(|=.*)$" &>/dev/null
	if [ $? -eq 0 ]; then
		printf "\$variable_not_declared is declared.\n"
		else
		printf "\$variable_not_declared is NOT declared.\n"
	fi
	printf "####################################################################################\n"
	
	printf "#############\n"
	
	## 正常結束 script 程式
	exit 0
}

# shell - How do I check if a variable exists in bash? - Unix & Linux Stack Exchange
# http://unix.stackexchange.com/a/269260/53916
var_is_declared() {
    { [[ -n ${!1+anything} ]] || declare -p $1 &>/dev/null;}
}

main
######## Program ended ########