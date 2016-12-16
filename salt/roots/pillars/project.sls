# Extra packages
extra_packages:
  - gcc
  - gcc-c++

# SCL packages available from: http://mirror.centos.org/centos/6/sclo/x86_64/
scl_packages:
  - devtoolset-3-gcc
  - devtoolset-3-gcc-c++

#node:
#  global_npm:
#    - grunt
#    - grunt@0.3 # specify a version

## Define custom VCL for project in config/salt_templates/varnish/default.vcl, backends.vcl, secret, etc.
#varnish:
#  vcl: salt://salt_templates/varnish/

# Custom Solr config files - place in config/salt_templates/solr-conf
#solr:
#  conf: salt://salt_templates/solr-conf

# Custom nginx server variables
#nginx:
#  server:
#    config:
#      http:
#        sendfile: 'off'

# Define nginx template
include:
  - nginx.drupal

# To override or add php settings, uncomment/add values below
#php:
#  ng:
#    cli:
#      ini:
#        settings:
#          PHP:
#            memory_limit: 256M
