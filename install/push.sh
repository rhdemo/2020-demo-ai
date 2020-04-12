#!/usr/bin/env bash
printf "\n\n######## digit-recognition image push ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ENV_FILE=${DIR}/../.env.dev
source ${ENV_FILE}
for ENV_VAR in $(sed 's/=.*//' ${ENV_FILE}); do export "${ENV_VAR}"; done

IMAGE=quay.io/redhatdemo/2020-digit-recognition
IMAGE_REPOSITORY=$IMAGE:latest

printf "\n######## Tagging model $LATEST_MODEL ########\n"
TAG=`docker inspect --format='{{index .Id}}' $IMAGE:$LATEST_MODEL`
echo "TAG = $TAG"
[ -z "$TAG" ] && printf "Image $IMAGE:$LATEST_MODEL with sha=$TAG not found.\nRun make build\n" && exit 1
docker tag $TAG $IMAGE_REPOSITORY

printf "\n######## Pushing Image $IMAGE_REPOSITORY ########\n"
docker push $IMAGE:$LATEST_MODEL
docker push ${IMAGE_REPOSITORY}
