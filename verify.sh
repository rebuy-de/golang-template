#!/bin/sh

set -euo pipefail

if [[ $# -ne 1 ]]
then
    echo "USAGE: $0 <PROJECT_DIR>"
    exit 1
fi

ROOT=$(dirname $0)
PROJECT_DIR=$( readlink -f $1 )
TEMPLATE_DIR=$( readlink -f ${ROOT}/templates )

function render {
    local source=${TEMPLATE_DIR}/files/${1}.tpl
    local target=${TEMPLATE_DIR}/generated/${1}

    local year=$(date +%Y)

    cat $source \
        | sed "s/__YEAR__/${year}/g" \
        > $target
}

mkdir -p ${TEMPLATE_DIR}/generated/
render LICENSE
render golang.mk
render Dockerfile

function show_diff {
    local source=${TEMPLATE_DIR}/generated/${1}
    local target=${PROJECT_DIR}/${1}

    echo "\$" diff $source $target
    diff -u $source $target || true
    echo -e "\n\n"
}

function verify_same {
    local source=${TEMPLATE_DIR}/generated/${1}
    local target=${PROJECT_DIR}/${1}
    if diff -qu $source $target > /dev/null
    then
        echo "File $1 is valid."
    else
        echo "File $1 is invalid. They should look the same:"
        show_diff ${1}
        exit 2
    fi
}

function verify_additions_only {
    local source=${TEMPLATE_DIR}/generated/${1}
    local target=${PROJECT_DIR}/${1}

    sed '/^$/d' $source > $source

    (set +eo pipefail

    if diff $source $target | grep -E '^<' > /dev/null
    then
        echo "File $1 is invalid. It should only contain additions:"
        show_diff ${1}
        exit 2
    else
        echo "File $1 is valid."
    fi
    )
}


verify_same LICENSE
verify_same golang.mk
verify_additions_only Dockerfile

echo "Verification succeeded."
