#!/bin/bash

VAGRANT_CORE_FOLDER="/vagrant"

if [[ -f "${VAGRANT_CORE_FOLDER}/Gemfile" ]]; then
  echo 'Installing bundler gems'
  su - vagrant -c "cd ${VAGRANT_CORE_FOLDER} && rbenv exec bundle install" >/dev/null
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/package.json" ]]; then
  echo 'Installing NPM packages'
  su - vagrant -c "cd ${VAGRANT_CORE_FOLDER} && npm install --silent --no-bin-links" >/dev/null
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/bower.json" ]]; then
  echo 'Installing bower packages'
  su - vagrant -c "cd ${VAGRANT_CORE_FOLDER} && bower install" >/dev/null
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/puppet/shell/custom/post-provision.sh" ]]; then
  source ${VAGRANT_CORE_FOLDER}/puppet/shell/custom/post-provision.sh
fi;

