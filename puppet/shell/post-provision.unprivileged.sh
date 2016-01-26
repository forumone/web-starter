#!/bin/bash

# Runs post-provision tasks as the Vagrant user

VAGRANT_CORE_FOLDER="/vagrant"

if [[ -f "${VAGRANT_CORE_FOLDER}/Gemfile" ]]; then
  echo 'Installing bundler gems'
  cd ${VAGRANT_CORE_FOLDER} && rbenv exec bundle install
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/package.json" ]]; then
  echo 'Installing NPM packages'
  cd ${VAGRANT_CORE_FOLDER} && npm install --silent --no-bin-links
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/bower.json" ]]; then
  echo 'Installing bower packages'
  cd ${VAGRANT_CORE_FOLDER} && bower install
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/puppet/shell/custom/post-provision.unprivileged.sh" ]]; then
  source ${VAGRANT_CORE_FOLDER}/puppet/shell/custom/post-provision.unprivileged.sh
fi;

