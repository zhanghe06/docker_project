#!/usr/bin/env bash

docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$PWD"/config:/.config/jesseduffield/lazydocker \
  lazyteam/lazydocker

#echo "alias lzd='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock lazyteam/lazydocker'" >> ~/.zshrc
