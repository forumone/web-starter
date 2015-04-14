#!/bin/bash

# A good place to put any post-provision actions that require root access.
# Just rename this file to "post-provision.sh" to make it active.

VAGRANT_CORE_FOLDER="/vagrant"

echo 'Installing s3cmd'
yum -y --enablerepo epel-testing install s3cmd
