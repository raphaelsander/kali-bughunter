#!/bin/bash

fail () {
    echo >&2 "[FAIL] $1"
    exit 1
}

for x in $(cat tools_list); do
    # some execution tests of the binary are skipped because return code different of 0 (sucess)
    if (echo "$x" | grep -q '\[NO-TEST\]'); then
        binary_name=$(echo "$x" | sed 's/\[NO-TEST\]//')
        test -f "/usr/bin/$binary_name" && echo "[OK] $binary_name" || fail "$binary_name"
    else
        $x -h &> /dev/null && echo "[OK] $x" || fail "$x"
    fi
done
