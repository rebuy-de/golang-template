#!/bin/bash

if [ $# -ne 1 ]
then
	echo "USAGE: $0 <target-dir>"
	exit -1
fi

root=$( dirname $0 )
target=$1
package=$(
	cd $target
	go list
)
binary=$( basename $package )

(
	cd ${root}
	latest_tag=$( git describe --abbrev=0 --tags )

	git show ${latest_tag}:example/golang.mk \
		> ${target}/golang.mk
	git show ${latest_tag}:example/Dockerfile \
		| sed \
			-e 's#github.com/rebuy-de/golang-template/example$#'${package}'#g' \
			-e 's#/go/bin/example#/go/bin/'${binary}'#g' \
		> ${target}/Dockerfile
)
