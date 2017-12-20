#!/bin/bash
set -o nounset
set -o errexit
set -o xtrace

function load_lib_for_distribution() {
  local distribution=$(uname)

  source "dist/${distribution}.sh"
}

function copy_home() {
  cp -r home/.* ~/
  #cp -r home/* ~/
}

function finish() {
  vim +PluginInstall +qall
}

function main() {
  load_lib_for_distribution
#  setup
#  install_tmux
#  install_git
#  install_vim
#  install_docker
#  install_ctags
  copy_home
  finish
  final_instructions
}

main
