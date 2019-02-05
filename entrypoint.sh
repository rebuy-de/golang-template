#!/bin/sh

target=/github/workspace

if [[ $# -eq 1 ]]
then
    target=${target}/$1
fi

/golang-template/verify.sh ${target}
