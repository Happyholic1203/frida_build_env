#!/bin/bash

. config.sh

docker run --workdir /frida/frida --entrypoint /bin/bash -it --rm -v "$(pwd)":/frida "${IMAGE}"
