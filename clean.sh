#!/bin/bash

. config.sh

docker rmi "${IMAGE}"
docker rmi "${PLAY_IMAGE}"
