#!/bin/bash

. config.sh

git clone --recurse-submodules https://github.com/frida/frida.git

docker build -t "${IMAGE}" .
