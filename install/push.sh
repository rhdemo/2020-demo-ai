#!/usr/bin/env bash
printf "\n\n######## digit-recognition image push ########\n"

IMAGE_REPOSITORY=quay.io/redhatdemo/2020-digit-recognition:latest

echo "Pushing ${IMAGE_REPOSITORY}"
docker push ${IMAGE_REPOSITORY}
