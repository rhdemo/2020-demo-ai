#!/usr/bin/env bash
printf "\n\n######## digit-recognition-server build locally ########\n"

IMAGE_REPOSITORY=quay.io/redhatdemo/2020-digit-recognition:latest
#SOURCE_REPOSITORY_URL=https://github.com/sub-mod/mnist-models
SOURCE_REPOSITORY_URL=git@github.com:rhdemo/2020-demo-ai.git
SOURCE_REPOSITORY_REF=master

echo "Building ${IMAGE_REPOSITORY}/2020-digit-recognition from ${SOURCE_REPOSITORY_URL} on ${SOURCE_REPOSITORY_REF}"

#s2i build ${SOURCE_REPOSITORY_URL} --ref ${SOURCE_REPOSITORY_REF} --context-dir cnn quay.io/aicoe/tensorflow-serving-s2i:2020 ${IMAGE_REPOSITORY}
s2i build ${SOURCE_REPOSITORY_URL} --ref ${SOURCE_REPOSITORY_REF} --context-dir model/mnist_cnn quay.io/aicoe/tensorflow-serving-s2i:2020 ${IMAGE_REPOSITORY}
