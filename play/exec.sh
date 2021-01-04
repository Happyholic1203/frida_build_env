#!/bin/bash

if [ -f config.sh ]; then
    . config.sh
elif [ -f ../config.sh ]; then
    . ../config.sh
fi

docker exec -it "${PLAY_NAME}" /bin/bash
