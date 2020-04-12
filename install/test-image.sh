#!/usr/bin/env bash
printf "\n\n######## digit-recognition image test ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ENV_FILE=${DIR}/../.env.dev
source ${ENV_FILE}
for ENV_VAR in $(sed 's/=.*//' ${ENV_FILE}); do export "${ENV_VAR}"; done

MODEL_DIR=${DIR}/../model/$LATEST_MODEL
cd ${DIR}/..
echo "PWD = $PWD"
IMAGE=quay.io/redhatdemo/2020-digit-recognition
IMAGE_REPOSITORY=$IMAGE:latest

printf "\n######## Test  model $LATEST_MODEL locally ########\n"


docker run --name 2020-demo-ai-test -t --rm -p 8501:8501 -p 8500:8500 \
  -e MODEL_NAME=mnist -e PORT=8500 -e REST_PORT=8501 -e TF_CPP_MIN_VLOG_LEVEL=0 \
  -e FILE_SYSTEM_POLL=1200 $IMAGE_REPOSITORY &

sleep 2;
prediction=$(curl -s -d @$MODEL_DIR/payload_9.json -X POST http://127.0.0.1:8501/v1/models/mnist:predict | jq --raw-output '.predictions[]' ) 
echo $prediction

printf "=======\n"
index=0
jq -c '.[]' <<< "$prediction" | while read i; do
    printf "$index $i\n"
    ((index++))
done
max_prediction=$(curl -s -d @$MODEL_DIR/payload_9.json -X POST http://127.0.0.1:8501/v1/models/mnist:predict | jq --raw-output '.predictions[] | max' )
printf "=======\n"
printf "$max_prediction\n"
printf "=======\n"

trap "docker stop 2020-demo-ai-test; exit 0" INT
wait
