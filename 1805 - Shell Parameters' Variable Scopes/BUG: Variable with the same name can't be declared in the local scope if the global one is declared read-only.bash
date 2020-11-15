#!/usr/bin/env bash
# BUG: Variable with the same name can't be declared in the local scope if the global one is declared read-only
# https://lists.gnu.org/archive/html/bug-bash/2020-11/msg00065.html
set \
    -o errexit \
    -o errtrace \
    -o nounset

declare -r variable_shadowed='(Value to be shadowed in the function)'

check_values_of_variables_in_different_scope(){
    local variable_shadowed="Another value"

    printf 'In the %s context: \n' "${FUNCNAME[0]}"
    printf 'variable_shadowed = %s\n' "${variable_shadowed}"
}
check_values_of_variables_in_different_scope
