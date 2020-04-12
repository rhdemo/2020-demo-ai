#!/usr/bin/env bash
printf "\n\n######## digit-recognition-server build locally ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ENV_FILE=${DIR}/../.env.dev
source ${ENV_FILE}
for ENV_VAR in $(sed 's/=.*//' ${ENV_FILE}); do export "${ENV_VAR}"; done

printf "\n######## Building model $LATEST_MODEL locally ########\n"

git-remote-url-reachable() {
    git ls-remote "$1" >/dev/null 2>&1 && return 0  || return 1
}

IMAGE_REPOSITORY=quay.io/redhatdemo/2020-digit-recognition:$LATEST_MODEL
#SOURCE_REPOSITORY_URL=https://github.com/sub-mod/mnist-models
SOURCE_REPOSITORY=rhdemo/2020-demo-ai.git
SOURCE_REPOSITORY_URL=git@github.com:$SOURCE_REPOSITORY
if !(git-remote-url-reachable "$SOURCE_REPOSITORY_URL"); then
   ## code
   echo "trying with http protocol..."
   SOURCE_REPOSITORY_URL=https://github.com/$SOURCE_REPOSITORY
fi

SOURCE_REPOSITORY_REF=master

echo "Building ${IMAGE_REPOSITORY} from ${SOURCE_REPOSITORY_URL} on ${SOURCE_REPOSITORY_REF}"

#s2i build ${SOURCE_REPOSITORY_URL} --ref ${SOURCE_REPOSITORY_REF} --context-dir cnn quay.io/aicoe/tensorflow-serving-s2i:2020 ${IMAGE_REPOSITORY}
s2i build ${SOURCE_REPOSITORY_URL} --ref ${SOURCE_REPOSITORY_REF} --context-dir model/$LATEST_MODEL quay.io/aicoe/tensorflow-serving-s2i:2020 ${IMAGE_REPOSITORY}
