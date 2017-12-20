#!/bin/bash
set -o nounset
set -o errexit

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

function install_python_linter() {
  pip install flake8
}

function install_javascript_linter() {
  npm install standard --save-dev
}

function install_json_linter() {
  npm install standard --save-dev
}

function install_dockerfile_linter() {
  npm install -g dockerfile_lint
}

function install_css_linter() {
  npm install -g csslint
}

function install_sql_linter() {
  sudo gem install sqlint
}

function install_yaml_linter() {
  pip install yamllint
}

function install_mdv() {
  pip install mdv
}

function install_httpie() {
  pip install httpie
}


function fetch_keys() {
  local user="${1}"

  echo "Fetching github keys for ${user}"
}

function error() {
  echo 1>&2 "ERROR: $@"
  echo
  usage
  exit 1
}

function usage() {
  cat <<EOF
Usage: ${0#./} [OPTIONS...]

Bootstrap a machine for local development, optionally creating
a new user with ssh keys fetched from github.

Options:

  --user <username>
    The name of a new user to create that is bootstrapped; If
    not specified, the current user is bootstrapped

  -h/--help
    Display this help message
EOF
}

function main() {
  local user=""
  local host=$(hostname)

  while [[ ${#} -gt 0 ]]; do
    echo "${1}"
    case "${1}" in
      --user)       user="${2}"; shift;;
      -h|--help)    usage; exit 0;;
      --)           break;;
      -*)           error "Unrecognized option ${1}";;
    esac
    shift
  done

  echo "Bootstrapping ${host}..."
  set -o xtrace

  load_lib_for_distribution
  setup
  install_openssl
  install_nmap
  install_pstree
  install_tmux
  install_git
  install_ctags
  install_gdb
  install_fswatch
  install_jq
  install_docker
  install_node
  install_python_linter
  install_shell_linter
  install_javascript_linter
  install_json_linter
  install_dockerfile_linter
  install_html_linter
  install_css_linter
  install_sql_linter
  install_yaml_linter
  install_vim
  install_mdv
  install_httpie
  # netstat?
  # nslookup?

  if [[ -z "${user}" ]]; then
    # bootstrapping with a new, non-root user
    create_user "${user}"
    sudo su "${user}"
    fetch_keys "${user}"
    copy_home
  else
    # bootstrapping the existing user
    copy_home
  fi

  finish
  final_instructions
}

main "$@"
