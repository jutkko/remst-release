#!/bin/bash

[ -z "$DEBUG" ] || set -x

set -eu

LOG_DIR=/var/vcap/sys/log/setup
PACKAGES=/var/vcap/packages

main() {
  send_all_output_to_logfile

  shell_setup
  install_scripts
  install_tigrc
  add_lpass_to_path
  add_tmux_to_path
  add_tig_to_path
  add_vim_to_path
  add_go_to_path
  export_goroot
  set_gopath

  ensure_lpass_in_login_shell_path
  ensure_tmux_in_login_shell_path
  ensure_tig_in_login_shell_path
  ensure_vim_in_login_shell_path
  ensure_go_in_login_shell_path

  install_copy_pasta
}

send_all_output_to_logfile() {
  exec 1> >(tee -a "${LOG_DIR}/add-to-path.log")
  exec 2> >(tee -a "${LOG_DIR}/add-to-path.log")
}

shell_setup() {
  # TODO this breaks monit in the VM, try to fix it
  printf "export HOME=/root" > /etc/profile.d/add-home-to-path.sh
  printf "Running bash-it install\n"
  (export HOME=/root && printf "N\n" | "$PACKAGES"/bash-it/install.sh)
  hostname remst
}

install_scripts() {
  mv "$PACKAGES/scripts" /root/
  printf "export PATH=/root/scripts:\$PATH" > /etc/profile.d/add-scripts-to-path.sh
}

install_tigrc() {
  mv "$PACKAGES/tig-2.2.1/config/.tigrc" /root/
}

add_tmux_to_path() {
  printf "export PATH=%s/tmux-2.3/bin:\$PATH" "$PACKAGES" > /etc/profile.d/add-tmux-to-path.sh
}

add_tig_to_path() {
  printf "export PATH=%s/tig-2.2.1/bin:\$PATH" "$PACKAGES" > /etc/profile.d/add-tig-to-path.sh
}

add_lpass_to_path() {
  printf "export PATH=%s/lastpass-cli:\$PATH" "$PACKAGES" > /etc/profile.d/add-lpass-to-path.sh
}

add_vim_to_path() {
  printf "export PATH=%s/vim-8.0.0124/bin:\$PATH" "$PACKAGES" > /etc/profile.d/add-vim-to-path.sh
  mv "$PACKAGES/vim-8.0.0124/.vim" /root/
}

add_go_to_path() {
  printf "export PATH=%s/go1.7.5/bin:\$PATH" "$PACKAGES" > /etc/profile.d/add-go-to-path.sh
}

export_goroot() {
  printf "export GOROOT=%s/go1.7.5" "$PACKAGES" > /etc/profile.d/export_goroot.sh
}

set_gopath() {
  mkdir /root/go
  printf "export GOPATH=/root/go\nexport PATH=\$GOPATH/bin:\$PATH"> /etc/profile.d/set_gopath.sh
}

ensure_lpass_in_login_shell_path() {
  bash -l -c "which lpass" || (printf "lpass not in PATH" && exit 1)
}

ensure_tmux_in_login_shell_path() {
  bash -l -c "which tmux" || (printf "tmux not in PATH" && exit 1)
}

ensure_tig_in_login_shell_path() {
  bash -l -c "which tig" || (printf "tig not in PATH" && exit 1)
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
  bash -l -c "go get -u github.com/jutkko/copy-pasta" || (printf "installing copy-pasta failed" && exit 1)
}

main
