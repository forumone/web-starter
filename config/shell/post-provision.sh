#!/bin/bash

# Run post-provision tasks that need to be root.

VAGRANT_CORE_FOLDER="/vagrant"

if [[ -f "${VAGRANT_CORE_FOLDER}/Gruntfile.js" ]]; then
  echo 'Installing Grunt'
  /usr/local/bin/npm install grunt-cli -g
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/bower.json" ]]; then
  echo 'Installing Grunt'
  /usr/local/bin/npm install bower -g
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/puppet/shell/custom/post-provision.sh" ]]; then
    source ${VAGRANT_CORE_FOLDER}/puppet/shell/custom/post-provision.sh
fi;