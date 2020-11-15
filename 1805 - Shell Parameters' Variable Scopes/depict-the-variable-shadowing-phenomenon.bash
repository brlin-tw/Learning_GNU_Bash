#!/usr/bin/env bash
# Depict the variable shadowing phenomenon
variable_shadowed='(Value to be shadowed in the function)'
variable_retained='(Value not shadowed in the function)'

printf 'In the "main" context(before the function call): \n'
printf 'variable_shadowed = %s\n' "${variable_shadowed}"
printf 'variable_retained = %s\n' "${variable_retained}"

check_values_of_variables_in_different_scope(){
    local variable_shadowed='(Value shadowed in the function)'

    printf 'In the %s context: \n' "${FUNCNAME[0]}"
    printf 'variable_shadowed = %s\n' "${variable_shadowed}"
    printf 'variable_retained = %s\n' "${variable_retained}"
}
check_values_of_variables_in_different_scope

printf 'In the "main" context(after the function call): \n'
printf 'variable_shadowed = %s\n' "${variable_shadowed}"
printf 'variable_retained = %s\n' "${variable_retained}"
