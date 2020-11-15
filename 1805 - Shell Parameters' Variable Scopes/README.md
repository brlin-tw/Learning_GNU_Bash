# Shell Parameters' Variable Scopes

This chapter explains various scope that whether a variable can be 'seen' by the script commands, and in some circumstances they may be 'shadowed' by others in the different scope.

## Global scope

### Definition

Variables declared/set in the `main` context are considered to be in the _global_ scope, which means that it can be 'seen' by all commands unless:

* It is _unset_ afterwards by using the `unset` builtin command
* It is _shadowed_ by an variable with the same name in the local scope

### Declaration

A _global variable_ can be declared by using the `declare -g` builtin command, or by simply writing:

```bash
_VARIABLE_NAME_=_VARIABLE_VALUE_
```

in the `main` context of the script (a.k.a. Any part of the code that is not in a function).

## Local Scope

### Definition

Variables declared/set in a function are considered to be in the _local scope_, which means that it can only be _seen_ in the function that it is defined in regular circumstances.

NOTE: A local variable can also be accessed by other functions by passing them via the name reference(nameref) Bash feature.

## Variable shadowing

### Definition

If two variables _with the same name_ are defined in both of the _global scope_ and the _local scope_ the variable in defined in the _local scope_ is known to _shadow_ the one in the global scope, which means that all references of the _name_ will get the value of the local variable, once it is declared.  This is called [_variable shadowing_](https://en.wikipedia.org/wiki/Variable_shadowing)

### Depiction script

[depict-the-variable-shadowing-phenomenon.bash](depict-the-variable-shadowing-phenomenon.bash)

## Known issues
### Variable with the same name can't be declared in the local scope if the global one is declared read-only

Reproducible sample: [BUG: Variable with the same name can't be declared in the local scope if the global one is declared read-only.bash](<BUG: Variable with the same name can't be declared in the local scope if the global one is declared read-only.bash>)
