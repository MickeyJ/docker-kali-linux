#!/usr/bin/env bash

CONTAINER_NAME_VERSION=${1}

echo ""
echo "Start ${CONTAINER_NAME_VERSION}"
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

docker start ${CONTAINER_NAME_VERSION} -i