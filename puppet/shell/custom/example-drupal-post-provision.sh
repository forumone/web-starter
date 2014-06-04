#!/bin/bash

VAGRANT_CORE_FOLDER="/vagrant"

if [[ -f "${VAGRANT_CORE_FOLDER}/public/sites/default/settings.vm.php" ]]; then
  if [[ ! -f "${VAGRANT_CORE_FOLDER}/public/sites/default/settings.php" || -w "${VAGRANT_CORE_FOLDER}/public/sites/default/settings.php" ]]; then
    echo 'Copying settings file'
    su - vagrant -c "cd ${VAGRANT_CORE_FOLDER}/public/sites/default && cp settings.vm.php settings.php" >/dev/null
  fi
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/public/htaccess.dev" ]]; then
  echo 'Copying .htaccess'
  su - vagrant -c "cd ${VAGRANT_CORE_FOLDER}/public && cp htaccess.dev .htaccess" > /dev/null
fi

if [[ ! -d "/home/vagrant/.drush" ]]; then
  echo 'Creating drush directory'
  su - vagrant -c "mkdir ~/.drush"
fi

echo 'Copying aliases'
find "${VAGRANT_CORE_FOLDER}" -maxdepth 1 -name "*.aliases.drushrc.php" -exec su - vagrant -c "cp {} ~/.drush/" \;

if [[ ! -f "/home/vagrant/.drush/drush.ini" ]]; then
  echo 'Creating drush settings'
  su - vagrant -c "echo 'memory_limit = 512M' > ~/.drush/drush.ini"
fi
