#!/usr/bin/env bash
# Aliases
# BASHDOC: Bash Features » Aliases

## Aliases are not expanded in non-interactive mode by default, enable it
shopt -s expand_aliases

## Alias of regular command
alias print_working_directory="pwd"
print_working_directory

printf "\n"

## Alias for function name
a_very_long_name_function(){
	echo "a_very_long_name_function called"
}; alias long_name_function=a_very_long_name_function
long_name_function

exit 0