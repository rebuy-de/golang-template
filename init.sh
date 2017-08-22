#!/bin/bash

set -euo pipefail

if [ $# -ne 1 ]
then
	echo "USAGE: $0 <target-dir>"
	exit -1
fi

root=$( dirname $0 )
target=$1

if [ -e ${target} ]
then
    echo "Target dir must not exist!"
    exit 1
fi

(
    set -x
    cp -a ./example ${target} 
    cd ${target}
    git init
    git add .
    git commit -m "copy golang-template"
)

cd $target

package=$(go list)
binary=$(basename $package)

for file in $(git ls-files)
do
    (
        set -x
        sed \
            -i \
            -e "s#github.com/rebuy-de/golang-template/example#${package}#g" \
            -e "s#/example#/${binary}#g" \
            ${file}
    )
done

(
    set -x
    git add .
    git commit -m "initialize template values"

    make build
)
