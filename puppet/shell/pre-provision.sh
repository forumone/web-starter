#!/bin/bash

VAGRANT_CORE_FOLDER="/vagrant"

# Create default self-signed SSL cert.
if [[ ! -f "/etc/pki/tls/private/localhost.key" ]]; then
    /usr/bin/openssl req -newkey rsa:2048 -nodes -keyout /etc/pki/tls/private/localhost.key  -x509 -days 365 -out /etc/pki/tls/certs/localhost.crt -subj '/CN=localhost.localdomain' > /dev/null
fi

if [[ -f "${VAGRANT_CORE_FOLDER}/puppet/shell/custom/pre-provision.sh" ]]; then
  source ${VAGRANT_CORE_FOLDER}/puppet/shell/custom/pre-provision.sh
fi;

