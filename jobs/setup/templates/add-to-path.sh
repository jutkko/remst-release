#!/bin/bash

[ -z "$DEBUG" ] || set -x

set -eu

LOG_DIR=/var/vcap/sys/log/setup

main() {
  add_tmux_to_path
  add_vim_to_path

  ensure_tmux_in_login_shell_path
  ensure_vim_in_login_shell_path
}

send_all_output_to_logfile() {
  exec 1> >(tee -a "${LOG_DIR}/add-to-path.log")
  exec 2> >(tee -a "${LOG_DIR}/add-to-path.log")
}

add_tmux_to_path() {
  echo "export PATH=/var/vcap/packages/tmux-2.3/bin:\$PATH" > /etc/profile.d/add-tmux-to-path.sh
}

add_vim_to_path() {
  echo "export PATH=/var/vcap/packages/vim-8.0.0124/bin:\$PATH" > /etc/profile.d/add-vim-to-path.sh
}

ensure_tmux_in_login_shell_path() {
  which tmux ||
  echo "tmux not in PATH" && exit 1
}

ensure_vim_in_login_shell_path() {
  which vim ||
  echo "vim not in PATH" && exit 1
}

send_all_output_to_logfile
main

