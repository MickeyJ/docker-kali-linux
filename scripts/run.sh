#!/usr/bin/env bash

CONTAINER_NAME_VERSION=${1}
IMAGE_NAME_LATEST=${2}

echo ""
echo "Running ${CONTAINER_NAME_VERSION} from ${IMAGE_NAME_LATEST}"
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

docker run --name ${CONTAINER_NAME_VERSION} -it ${IMAGE_NAME_LATEST}
