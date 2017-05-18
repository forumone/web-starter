#!/bin/bash

VAGRANT_CORE_FOLDER="/vagrant"

# Add hostname to /etc/hosts for ipv6. Vagrant doesn't handle natively
sed -i '/^::1 / s/$/ vagrant.byf1.io/' /etc/hosts

if [[ -f "${VAGRANT_CORE_FOLDER}/config/shell/custom/pre-provision.sh" ]]; then
  source ${VAGRANT_CORE_FOLDER}/config/shell/custom/pre-provision.sh
fi;

