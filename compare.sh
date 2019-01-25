#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "USAGE: $0 <PROJECT_DIR>"
    exit 1
fi

ROOT=$(dirname $0)
PROJECT_DIR=$( readlink -f $1 )
TEMPLATE_DIR=$( readlink -f ${ROOT}/templates )

set -euox pipefail

mkdir -p ${TEMPLATE_DIR}/generated
rm -f ${TEMPLATE_DIR}/generated/LICENSE
rm -f ${TEMPLATE_DIR}/generated/golang.mk
rm -f ${TEMPLATE_DIR}/generated/Dockerfile

sed < ${TEMPLATE_DIR}/files/LICENSE.tpl "s/XXXX/$(date +%Y)/g" > ${TEMPLATE_DIR}/generated/LICENSE

cat ${TEMPLATE_DIR}/files/_header.tpl > ${TEMPLATE_DIR}/generated/golang.mk
cat ${TEMPLATE_DIR}/files/golang.mk.tpl >> ${TEMPLATE_DIR}/generated/golang.mk

cat ${TEMPLATE_DIR}/files/_header.tpl > ${TEMPLATE_DIR}/generated/Dockerfile
cat ${TEMPLATE_DIR}/files/Dockerfile.tpl >> ${TEMPLATE_DIR}/generated/Dockerfile

diff ${TEMPLATE_DIR}/generated/LICENSE $PROJECT_DIR/LICENSE
diff ${TEMPLATE_DIR}/generated/golang.mk $PROJECT_DIR/golang.mk

diff \
    --changed-group-format='%>' \
    --unchanged-group-format='' \
    $PROJECT_DIR/Dockerfile \
    ${TEMPLATE_DIR}/generated/Dockerfile

exit 0
