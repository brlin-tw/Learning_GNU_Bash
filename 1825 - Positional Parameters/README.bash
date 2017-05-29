#!/usr/bin/env bash
printf "Positional Parameters\n"
printf "=========================\n"
printf "BASHDOC: Basic Shell Features » Shell Parameters » Special Parameters\n"
printf "Total quantity of positional parameters(not include \${0}, which is NOT a positional parameter but a special parameter)\n"
printf -- "-------------------------\n"
printf "\${#} = %u\n" "${#}"
printf "\n"

printf "Enumerate all positional parameters\n"
printf -- "-------------------------\n"
# NOTE: ${0} is NOT a positional parameter, instead it is a special parameter
# BASHDOC: Basic Shell Features » Shell Parameters » Special Parameters
counter="1"
for positional_parameter in "${@}"; do
	printf "* \${%u} = %s\n" "${counter}" "${positional_parameter}"
	counter="$((counter + 1 ))"
done
unset counter
printf "\n"

exit 0
