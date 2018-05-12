#!/usr/bin/env bash
# 參考資料：GNU Bash infodoc 格式使用手冊/Bourne Shell Builtins
# 林博仁 <Buo.Ren.Lin@gmail.com> © 2016, 2017
#
# shellcheck disable=SC1090
source "$(dirname "${BASH_SOURCE[0]}")/SOFTWARE_INSTALLATION_PREFIX_DIR.source.bash"
source "$(dirname "${BASH_SOURCE[0]}")/${SOFTWARE_INSTALLATION_PREFIX_DIR}/9999 - Commons/Enable strict mode.source.bash"

printf '# getopts demonstration #\n'
printf '* OPTERR=%u\n' "${OPTERR}"
printf '\n'

# printf '## Demonstrating Normal Mode(Not Implemented Yet) ##\n'
#
# printf '\n'
#
# printf '## Demonstrating Silent Mode ##\n'

# OPTIND is initialized to 1 each time the shell or a shell script is invoked.
# The shell does not reset OPTIND automatically; it must be manually reset between multiple calls to `getopts` within the same shell invocation if a new set of parameters is to be used.
OPTIND=1
declare next_option
while getopts ':dhv' next_option; do
	printf "next option's index is %u\\n" "${OPTIND}"
	printf 'next_option is %s\n' "${next_option}"

	if [ "${next_option}" == '?' ]; then
		printf 'Invalid option: %s\n' "${OPTARG}"
		# break # Normally we'd break the loop and stop parsing and terminates the program, but for educational purposed we continue
	else
		case "${next_option}" in
			d)
				echo "-${next_option} found"
			;;
			h)
				echo "-${next_option} found"
			;;
			v)
				echo "-${next_option} found, with the argument ${OPTARG}"
			;;
		esac
	fi
done; unset next_option
exit 0
