#!/bin/bash
function parse_with_for_in() {
    for arg in "$@"
    do
        echo $arg
    done
}
function parse_with_expansion() {
    for ((i = 1; i <= $#; i++))
    do
        echo ${!i} # Indirect expansion syntax
    done
}
parse_with_for_in "$@"
echo "---"
parse_with_expansion "$@"