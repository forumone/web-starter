#!/bin/bash

# Post provision actions that do not require root access.
# This version of the file contains common post-provision steps for Drupal sites.

# Just rename this file to "post-provision.unprivileged.sh" to make it active.

VAGRANT_CORE_FOLDER="/vagrant"

if [[ -f "${VAGRANT_CORE_FOLDER}/public/sites/default/settings.vm.php" ]]; then
  if [[ ! -f "${VAGRANT_CORE_FOLDER}/public/sites/default/settings.php" || -w "${VAGRANT_CORE_FOLDER}/public/sites/default/settings.php" ]]; then
    echo 'Copying settings file'
    cd ${VAGRANT_CORE_FOLDER}/public/sites/default && cp settings.vm.php settings.php
  fi
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/public/htaccess.dev" ]]; then
  echo 'Copying .htaccess'
  cd ${VAGRANT_CORE_FOLDER}/public && cp htaccess.dev .htaccess
fi

if [[ ! -d "/home/vagrant/.drush" ]]; then
  echo 'Creating drush directory'
  mkdir ~/.drush
fi

echo 'Copying aliases'
find "${VAGRANT_CORE_FOLDER}" -maxdepth 1 -name "*.aliases.drushrc.php" -exec cp {} ~/.drush/ \;

if [[ ! -f "/home/vagrant/.drush/drush.ini" ]]; then
  echo 'Creating drush settings'
  echo 'memory_limit = 512M' > ~/.drush/drush.ini
fi
