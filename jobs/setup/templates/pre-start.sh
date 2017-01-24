#!/bin/bash -e

[ -z "$DEBUG" ] || set -x

apt-get install xclip -y
apt-get install git -y
git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm
