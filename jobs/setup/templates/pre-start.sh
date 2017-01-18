#!/bin/bash -e

[ -z "$DEBUG" ] || set -x

TMUX_DIR=/var/vcap/packages/tmux-2.3

apt-get install git -y
git clone https://github.com/tmux-plugins/tpm ${TMUX_DIR}/.tmux/plugins/tpm
