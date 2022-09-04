#!/usr/bin/env bash

set -x

echo "Searching for Docker image ..."
DOCKER_IMAGE_ID=$(sudo docker images --format="{{.ID}}" soundsync:ubuntu22.04 | head -n 1)
echo "Found and using ${DOCKER_IMAGE_ID}"

USER_UID=$(id -u)

sudo docker run -t -i \
  --volume=/run/user/${USER_UID}/pulse:/run/user/1000/pulse \
  --hostname=${HOSTNAME}-docker \
  ${DOCKER_IMAGE_ID} \
  ${@}
