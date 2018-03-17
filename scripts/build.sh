#!/usr/bin/env bash

USER_NAME=${1}
PASSWORD=${2}
VERSION=${3}
IMAGE_REPO=mickeyjr
IMAGE_NAME=linux-${USER_NAME}
IMAGE_NAME_LATEST=${IMAGE_REPO}/${IMAGE_NAME}:latest
IMAGE_NAME_VERSION=${IMAGE_REPO}/${IMAGE_NAME}:v${VERSION}
CONTAINER_NAME_VERSION=${IMAGE_NAME}-v${VERSION}

#BUILD_ARGS="USER_NAME=${USER_NAME} VERSION=${VERSION}"

echo ""
echo "Building ${IMAGE_NAME_VERSION}"
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

docker build \
    -t ${IMAGE_NAME_VERSION} \
    --build-arg USER_NAME=${USER_NAME} \
    --build-arg PASSWORD=${PASSWORD} \
    --build-arg VERSION=${VERSION} \
    .

docker build \
    -t ${IMAGE_NAME_LATEST} \
    --build-arg USER_NAME=${USER_NAME} \
    --build-arg PASSWORD=${PASSWORD} \
    --build-arg VERSION=${VERSION} \
    .

#docker push ${IMAGE_NAME_LATEST}