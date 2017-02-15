#!/bin/bash -e

[ -z "$DEBUG" ] || set -x

apt-get update

# for tmux's copy and paste
apt-get install -y xclip

apt-get install -y git

# for lpass
apt-get install -y openssl \
  libcurl3 \
  libxml2 \
  libssl-dev \
  libxml2-dev \
  libcurl4-openssl-dev \
  pinentry-curses
