#!/bin/bash

. config.sh

docker run \
    --name "${NAME}" \
    --workdir /frida/frida \
    --entrypoint /bin/bash \
    -it --rm -v "$(pwd)":/frida "${IMAGE}"
