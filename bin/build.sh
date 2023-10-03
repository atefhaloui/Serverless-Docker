#!/bin/bash
set -e

export SERVERLESS_RELEASE=$(cat VERSION | grep 'SERVERLESS' | cut -d ':' -f 2)
export NODE_MAJOR=$(cat VERSION | grep 'NODE_MAJOR' | cut -d ':' -f 2)

if [[ -z ${SERVERLESS_RELEASE} ]]; then
    echo "Error: undefined SERVERLESS_RELEASE environment variable."
    exit 1
fi

docker build \
  --build-arg SERVERLESS_RELEASE="${SERVERLESS_RELEASE}" \
  --build-arg NODE_MAJOR="${NODE_MAJOR}" \
  -t atefhaloui/serverless .
docker tag atefhaloui/serverless:latest atefhaloui/serverless:"${SERVERLESS_RELEASE}"
