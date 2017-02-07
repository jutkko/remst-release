#!/bin/bash

[ -z "$DEBUG" ] || set -x

set -eu

LOG_DIR=/var/vcap/sys/log/setup

main() {
  add_tmux_to_path
  add_vim_to_path
  add_go_to_path
  export_goroot
  set_gopath

  ensure_tmux_in_login_shell_path
  ensure_vim_in_login_shell_path
  ensure_go_in_login_shell_path

  install_copy_pasta
}

send_all_output_to_logfile() {
  exec 1> >(tee -a "${LOG_DIR}/add-to-path.log")
  exec 2> >(tee -a "${LOG_DIR}/add-to-path.log")
}

add_tmux_to_path() {
  printf "export PATH=/var/vcap/packages/tmux-2.3/bin:\$PATH" > /etc/profile.d/add-tmux-to-path.sh
}

add_vim_to_path() {
  printf "export PATH=/var/vcap/packages/vim-8.0.0124/bin:\$PATH" > /etc/profile.d/add-vim-to-path.sh
}

add_go_to_path() {
  printf "export PATH=/var/vcap/packages/go1.7.5/bin:\$PATH" > /etc/profile.d/add-go-to-path.sh
}

export_goroot() {
  printf "export GOROOT=/var/vcap/packages/go1.7.5" > /etc/profile.d/export_goroot.sh
}

set_gopath() {
  mkdir /root/go
  printf "export GOPATH=/root/go\nexport PATH=\$GOPATH/bin:\$PATH"> /etc/profile.d/set_gopath.sh
}

ensure_tmux_in_login_shell_path() {
  bash -l -c "which tmux" || (printf "tmux not in PATH" && exit 1)
}

ensure_vim_in_login_shell_path() {
  bash -l -c "which vim" || (printf "vim not in PATH" && exit 1)
}

ensure_go_in_login_shell_path() {
  bash -l -c "which go" || (printf "go not in PATH" && exit 1)
  bash -l -c "which godoc" || (printf "godoc not in PATH" && exit 1)
  bash -l -c "which gofmt" || (printf "gofmt not in PATH" && exit 1)
}

install_copy_pasta() {
  bash -l -c "go get -u github.com/jutkko/copy-pasta"
}

send_all_output_to_logfile
main
