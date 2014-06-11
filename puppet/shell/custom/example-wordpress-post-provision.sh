#!/bin/bash

VAGRANT_CORE_FOLDER="/vagrant"

if [[ -f "${VAGRANT_CORE_FOLDER}/public/wp-config.vm.php" ]]; then
  if [[ ! -f "${VAGRANT_CORE_FOLDER}/public/wp-config.php" || -w "${VAGRANT_CORE_FOLDER}/public/wp-config.php" ]]; then
    echo 'Copying wp-config file'
    su - vagrant -c "cd ${VAGRANT_CORE_FOLDER}/public && cp wp-config.vm.php wp-config.php" >/dev/null
  fi
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/public/htaccess.dev" ]]; then
  echo 'Copying .htaccess'
  su - vagrant -c "cd ${VAGRANT_CORE_FOLDER}/public && cp htaccess.dev .htaccess" > /dev/null
fi