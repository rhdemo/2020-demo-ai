#!/usr/bin/env bash
printf "\n\n######## demo ai dev ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ENV_FILE=${DIR}/../.env.dev
source ${ENV_FILE}
for ENV_VAR in $(sed 's/=.*//' ${ENV_FILE}); do export "${ENV_VAR}"; done

MODEL_DIR=${DIR}/../model/$LATEST_MODEL
cd ${DIR}/..
echo "PWD = $PWD"

printf "\n######## Starting model $LATEST_MODEL locally ########\n"


docker run --name 2020-demo-ai -t --rm -p 8501:8501 -p 8500:8500 \
  -v "$MODEL_DIR:/opt/app-root/src/" \
  -e MODEL_NAME=mnist -e PORT=8500 -e REST_PORT=8501 \
  -e FILE_SYSTEM_POLL=30 quay.io/aicoe/tensorflow-serving-s2i:2020 /usr/libexec/s2i/run &

sleep 2;
payload=`cat $MODEL_DIR/payload.json`
echo "$payload"
curl -d @$MODEL_DIR/payload.json -X POST http://127.0.0.1:8501/v1/models/mnist:predict
#curl -d '{"signature_name":"serving_default", "instances":[{"reshape_input":[]}] }' -X POST http://127.0.0.1:8501/v1/models/mnist:predict

trap "docker stop 2020-demo-ai; exit 0" INT
wait
