#!/bin/bash

# Post provision actions that do not require root access.
# This version of the file contains common post-provision steps for Wordpress sites.

# Just rename this file to "post-provision.unprivileged.sh" to make it active.

VAGRANT_CORE_FOLDER="/vagrant"

if [[ -f "${VAGRANT_CORE_FOLDER}/public/wp-config.vm.php" ]]; then
  if [[ ! -f "${VAGRANT_CORE_FOLDER}/public/wp-config.php" || -w "${VAGRANT_CORE_FOLDER}/public/wp-config.php" ]]; then
    echo 'Copying wp-config file'
    cd ${VAGRANT_CORE_FOLDER}/public && cp wp-config.vm.php wp-config.php
  fi
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/public/htaccess.dev" ]]; then
  echo 'Copying .htaccess'
  cd ${VAGRANT_CORE_FOLDER}/public && cp htaccess.dev .htaccess
fi
