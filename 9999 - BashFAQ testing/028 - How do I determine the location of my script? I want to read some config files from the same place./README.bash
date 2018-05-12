#!/usr/bin/env bash
# How do I determine the location of my script? I want to read some config files from the same place. <http://mywiki.wooledge.org/BashFAQ/028>
# 林博仁 <Buo.Ren.Lin@gmail.com> © 2017
if [ -z "${BASH_SOURCE[0]}" ]; then
	printf "The first member of BASH_SOURCE is empty, Bash doesn't know where this script comes from(usually stdin).\\n"
else
	printf 'According to BASH_SOURCE, this script comes from "%s".\n' "${BASH_SOURCE[0]}"
	# Not a command substitution
	# shellcheck disable=SC2016
	printf 'Which is by `realpath --canonicalize-existing --no-symlinks`, "%s".\n' "$(realpath --canonicalize-existing --no-symlinks "${BASH_SOURCE[0]}")"
fi
exit 0
