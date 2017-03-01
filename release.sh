#!/bin/bash

if [ $# -ne 1 ]
then
	echo "USAGE: $0 <new-version>"
	exit 1
fi

if ! git diff-index --quiet HEAD
then
	echo "There are uncommited changes. Refusing to do a release."
	exit 1
fi

function set_version {
	(
		set -ex
		sed -i -e 's/^# Version: .*$/# Version: '$1'/g' $2
	)
}

function ask_to_continue {
	echo
	read -p "${@} (y/N) " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
		echo "Fine."
		exit 1
	fi
}

version=$1
next=$( echo "${version}" | awk -F. '{$NF = $NF + 1;} 1' | sed 's/ /./g' )-snapshot

echo "Bumping to ${version}"
set_version $version example/golang.mk
set_version $version example/Dockerfile

git add .
git --no-pager diff HEAD
ask_to_continue "Do you want to commit these changes?"

git commit -m "Release ${version}"
git tag -m "Release ${version}" v${version}

set_version $version example/golang.mk
set_version $version example/Dockerfile

echo "Bumping to ${next}"
set_version $next example/golang.mk
set_version $next example/Dockerfile

git add .
git --no-pager diff HEAD
ask_to_continue "Do you want to commit these changes?"
git commit -m "Release ${next}"

echo "Releasing done. You have to push it by yourself."
