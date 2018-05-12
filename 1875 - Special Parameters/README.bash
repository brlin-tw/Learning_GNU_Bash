#!/usr/bin/env bash
printf 'Special Parameters\n'
printf '=========================\n'
printf 'BASHDOC: Basic Shell Features » Shell Parameters » Special Parameters\n'
printf '\n'
# ${0} is not an expansion
# shellcheck disable=SC2016
printf '${0} = %s\n' "${0}"
exit 0
