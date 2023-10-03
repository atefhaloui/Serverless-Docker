#!/bin/bash
set -e
export SERVERLESS_RELEASE=`cat VERSION | grep 'SERVERLESS' | cut -d ':' -f 2`

echo "$DOCKER_PASS" | docker login --username "$DOCKER_USER" --password-stdin

docker push atefhaloui/serverless:latest
docker push atefhaloui/serverless:"${SERVERLESS_RELEASE}"
