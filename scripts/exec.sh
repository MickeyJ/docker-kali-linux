#!/usr/bin/env bash

if [ -z "$4" ]
then
    echo "Missing arguments"
    exit 1
fi

CMD=${1}
USER_NAME=${2}
PASSWORD=${3}
VERSION=${4}
IMAGE_REPO=mickeyjr
IMAGE_NAME=linux-${USER_NAME}
IMAGE_NAME_LATEST=${IMAGE_REPO}/${IMAGE_NAME}:latest
IMAGE_NAME_VERSION=${IMAGE_REPO}/${IMAGE_NAME}:v${VERSION}
CONTAINER_NAME_VERSION=${IMAGE_NAME}-v${VERSION}

BUILD_SCRIPT=./scripts/build.sh
RUN_SCRIPT=./scripts/run.sh
START_SCRIPT=./scripts/start.sh


buildImages(){
    sh ${BUILD_SCRIPT} ${USER_NAME} ${PASSWORD} ${VERSION}
}

runImage(){
    sh ${RUN_SCRIPT} ${CONTAINER_NAME_VERSION} ${IMAGE_NAME_LATEST}
}

startContainer(){
    sh ${START_SCRIPT} ${CONTAINER_NAME_VERSION}
}

if [ "$CMD" = "build" ]
then
    buildImages
    exit 0

elif [ "$CMD" = "build-run" ]
then
    buildImages
    runImage
    exit 0

elif [ "$CMD" = "run" ]
then
    runImage
    exit 0

elif [ "$CMD" = "start" ]
then
    startContainer
    exit 0

else
    echo "Command argument '${CMD}' is invalid"

fi

