#!/usr/bin/env bash
# List all Bash variables and their values
# 林博仁 © 2018

set \
	-o nounset \
	-o errexit

init(){
	for bash_variable in \
		BASH \
		BASHOPTS \
		BASHPID \
		BASH_ALIASES \
		BASH_ARGC \
		BASH_ARGV \
		BASH_CMDS \
		BASH_COMMAND \
		BASH_COMPAT \
		BASH_ENV \
		BASH_EXECUTION_STRING \
		BASH_LINENO \
		BASH_SOURCE \
		BASH_SUBSHELL \
		BASH_VERSINFO \
		BASH_VERSION \
		BASH_XTRACEFD \
		CHILD_MAX \
		COLUMNS \
		COMP_CWORD \
		COMP_LINE \
		COMP_POINT \
		COMP_TYPE \
		COMP_KEY \
		COMP_WORDBREAKS \
		COMP_WORDS \
		COMPREPLY \
		COPROC \
		DIRSTACK \
		EMACS \
		ENV \
		EUID \
		FCEDIT \
		FIGNORE \
		FUNCNAME \
		FUNCNEST \
		GLOBIGNORE \
		GROUPS \
		histchars \
		HISTCMD \
		HISTCONTROL \
		HISTFILE \
		HISTFILESIZE \
		HISTIGNORE \
		HISTSIZE \
		HISTTIMEFORMAT \
		HOSTFILE \
		HOSTNAME \
		HOSTTYPE \
		IGNOREEOF \
		INPUTRC \
		LANG \
		LC_ALL \
		LC_COLLATE \
		LC_CTYPE \
		LC_MESSAGES \
		LC_NUMERIC \
		LINENO \
		LINES \
		MACHTYPE \
		MAILCHECK \
		MAPFILE \
		OLDPWD \
		OPTERR \
		OSTYPE \
		PIPESTATUS \
		POSIXLY_CORRECT \
		PPID \
		PROMPT_COMMAND \
		PROMPT_DIRTRIM \
		PS3 \
		PS4 \
		PWD \
		RANDOM \
		READLINE_LINE \
		READLINE_POINT \
		REPLY \
		SECONDS \
		SHELL \
		SHELLOPTS \
		SHLVL \
		TIMEFORMAT \
		TMOUT \
		TMPDIR \
		UID
		do
		print_value_if_available \
			"${bash_variable}"
	done

	exit 0
}

print_value_if_available(){
	local -n bash_variable_ref="${1}"

	if ! test -v bash_variable_ref; then
		printf -- \
			'%s is not declared\n' \
			"${!bash_variable_ref}"
	else
		# bash - What is indirect expansion? What does ${!var*} mean? - Stack Overflow
		# https://stackoverflow.com/questions/8515411/what-is-indirect-expansion-what-does-var-mean#8515492
		# TIP: If the indirection is applied to the nameref the effect is actually the opposite
		# Bash check if variable is array - Stack Overflow
		# https://stackoverflow.com/questions/14525296/bash-check-if-variable-is-array
		# TODO: It should be able to merge array handling of assoc. and indexed arrays, however I need to know how to let grep match either or declare -[Aa]
		if declare -p "${!bash_variable_ref}" 2>/dev/null \
			| grep -q '^declare \-A'; then
			# associative array
			for key in "${!bash_variable_ref[@]}"; do
				printf -- \
					'%s[%u] = %s\n' \
					"${!bash_variable_ref}" \
					"${key}" \
					"${bash_variable_ref["${key}"]}"
			done
		elif declare -p "${!bash_variable_ref}" 2>/dev/null \
			| grep -q '^declare \-a'; then
			# indexed array
			local i
			for (( i = 0; i < ${#bash_variable_ref[@]}; i++ )); do
				printf -- \
					'%s[%u] = %s\n' \
					"${!bash_variable_ref}" \
					"${i}" \
					"${bash_variable_ref[i]}"
			done
			unset i
		else
			# string
			printf -- \
				'%s = %s\n' \
				"${!bash_variable_ref}" \
				"${bash_variable_ref}"
		fi
	fi
}

init