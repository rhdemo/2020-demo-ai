#!/usr/bin/env bash
printf "\n\n######## demo ai dev ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MODEL_DIR=${DIR}/../model/mnist_cnn

cd ${DIR}/..
pwd

docker run --name 2020-demo-ai -t --rm -p 8501:8501 -p 8500:8500 \
  -v "$MODEL_DIR:/opt/app-root/src/" \
  -e MODEL_NAME=mnist -e PORT=8500 -e REST_PORT=8501 \
  -e FILE_SYSTEM_POLL=30 quay.io/aicoe/tensorflow-serving-s2i:2020 /usr/libexec/s2i/run &


trap "docker stop 2020-demo-ai; exit 0" INT
wait
