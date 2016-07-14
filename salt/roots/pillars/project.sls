# Extra packages
extra_packages:
  - gcc
  - gcc-c++

## Define custom VCL for project in config/custom/varnish/default.vcl, backends.vcl, secret, etc.
#varnish:
#  vcl: salt://custom/varnish/

# Custom Solr config files
#solr:
#  conf: salt://custom/solr-conf

# Define nginx template
{% include 'nginx/drupal.sls' %}

# include Yeoman generated settings
include:
  - generated
