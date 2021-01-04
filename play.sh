#!/bin/bash

. config.sh

build_play_image() {
    set -e
    builddir="$(mktemp -d)"
    olddir="${PWD}"
    cd "${builddir}"

    cat<<EOF > Dockerfile
FROM ${IMAGE}

USER root

RUN apt install --no-install-recommends -yq python3-pip && \
    pip3 install colorama prompt_toolkit pygments

USER frida

ENTRYPOINT [/bin/bash]
EOF

    docker build -t "${PLAY_IMAGE}" .
    rm -rf "${builddir}"
    cd "${olddir}"
    set +e
}

docker inspect "${PLAY_IMAGE}" || build_play_image
docker run \
    --entrypoint /bin/bash \
    -v "${PWD}":/frida \
    --workdir /frida/frida \
    -it --rm "${PLAY_IMAGE}"
