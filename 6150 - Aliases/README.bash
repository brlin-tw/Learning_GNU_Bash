#!/usr/bin/env bash
# Aliases
# BASHDOC: Bash Features » Aliases

## Aliases are not expanded in non-interactive mode by default, enable it
shopt -s expand_aliases

## Alias of regular command
alias print_working_directory=pwd
print_working_directory

printf '\n'

## Alias for function name
a_very_long_name_function(){
	echo "a_very_long_name_function called"
}; alias long_name_function=a_very_long_name_function
long_name_function

## NOTE: For some reason aliases don't work if the LINENO of it's declaration isn't lesser than it's reference, even it is called later than the declaration because it is in function
a_lesser_lineno_define_but_greater_lineno_called_function(){
	if ! an_greater_lineno_declared_alias 2>/dev/null; then
		echo "${FUNCNAME[0]}: an_greater_lineno_declared_alias not found"
	else
		echo "${FUNCNAME[0]}: an_greater_lineno_declared_alias found"
	fi
}

alias an_greater_lineno_declared_alias="pwd"
a_lesser_lineno_define_but_greater_lineno_called_function

exit 0
