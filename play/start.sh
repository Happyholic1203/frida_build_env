#!/bin/bash

if [ -f config.sh ]; then
    . config.sh
    mount="${PWD}"
elif [ -f ../config.sh ]; then
    . ../config.sh
    mount="${PWD}/.."
else
    echo >&2 "config.sh not found"
    exit 1
fi

build_play_image() {
    set -e
    builddir="$(mktemp -d)"
    olddir="${PWD}"
    cd "${builddir}"

    cat<<EOF > Dockerfile
FROM ${IMAGE}

USER root

RUN apt install --no-install-recommends -yq python3-pip vim && \
    pip3 install colorama prompt_toolkit pygments

USER frida

ENTRYPOINT [/bin/bash]
EOF

    docker build -t "${PLAY_IMAGE}" .
    rm -rf "${builddir}"
    cd "${olddir}"
    set +e
}

docker inspect "${PLAY_IMAGE}" >/dev/null 2>&1 || build_play_image
docker run \
    --privileged \
    --user root \
    --name "${PLAY_NAME}" \
    --entrypoint /bin/bash \
    -v "${mount}":/frida \
    --workdir /frida/frida \
    -it --rm "${PLAY_IMAGE}"
