function setup() {
  # TODO install homebrew
  brew update
  install_or_upgrade "findutils"
  install_or_upgrade "gawk"
  install_or_upgrade "gsed"

  rename "gawk" "awk"
  rename "gsed" "sed"
}

function install_tmux() {
  install_or_upgrade "reattach-to-user-namespace"
  install_or_upgrade "tmux"
}

function install_git() {
  install_or_upgrade "git"
}

function install_vim() {
  install_or_upgrade "vim"

  rm -rf ~/.vim/bundle/Vundle.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

function install_docker() {
  # See
  # - https://docs.docker.com/docker-for-mac/install/#download-docker-for-mac
  # - https://apple.stackexchange.com/questions/73926/is-there-a-command-to-install-a-dmg
  wget https://download.docker.com/mac/stable/Docker.dmg
  hdiutil attach Docker.dmg
  cp -R /Volumes/Docker/Docker.app /Applications
  hdiutil detach /Volumes/Docker
  rm Docker.dmg
}

function install_ctags() {
  install_or_upgrade "ctags"
}

function final_instructions() {
  cat << EOF
Bootstrapping is complete!  You still need to enable regular use of function
keys.  Go to "System preferences -> Keyboard" and check "Use all F1, F2, ..."
You may also need to turn off Mission Control mappings to function keys.  Go
to "System preferences -> Mission Control" and make sure you see no references
to function keys.

Happy hacking!
EOF
}

function install_or_upgrade() {
  local package="${1}"

  brew install "${package}" || brew upgrade "${package}"
}

function rename() {
  local command="${1}"
  local new_command="${2}"
  local abs_new_command="/usr/local/bin/${new_command}"

  ln -s $(which "${command}") "${abs_new_command}"
}
