## Using Docker to Play with Frida

1. `./init.sh`
2. `./make.sh tools-linux-x86`
3. `./run.sh` to play with Frida (or use the following alias method)

## Using Host System to Play with Frida

Meant as a helper for building/rebuilding Frida. Here's a couple helpers to put into your `.bashrc` file:

```bash
alias frida_build="sudo docker run -it --rm -v $PWD:/frida bannsec/frida_build"

# This assumes you're inside a python virtualenv
function frida_build_deploy {
sudo docker run -it --rm -v $PWD:/frida bannsec/frida_build $@
cp -rf build/frida-linux-x86_64/lib/python*/site-packages/* $VIRTUAL_ENV/lib/python*/site-packages/.
}
```

For example, to build a custom version of frida and deploy it into your current virtual environment, just do:

```bash
# cd into your working dir
cd frida
frida_build_deploy python-linux-x86_64 PYTHON=/usr/bin/python3
```
