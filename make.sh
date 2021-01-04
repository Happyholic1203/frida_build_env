#!/bin/bash

. config.sh

docker run --workdir /frida/frida --entrypoint /bin/bash -t --rm -v "$(pwd)":/frida "${IMAGE}" -c "make $@"
