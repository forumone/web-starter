#!/bin/bash

VAGRANT_CORE_FOLDER="/vagrant"

if [[ -f "${VAGRANT_CORE_FOLDER}/public/sites/default/settings.vm.php" ]]; then
  echo 'Copying settings file'
  su - vagrant -c "cd ${VAGRANT_CORE_FOLDER}/public/sites/default && cp settings.vm.php settings.php" >/dev/null
fi
