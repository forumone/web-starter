# Extra packages
extra_packages:
  - gcc
  - gcc-c++

## Define custom VCL for project in config/salt_templates/varnish/default.vcl, backends.vcl, secret, etc.
#varnish:
#  vcl: salt://varnish/

# Custom Solr config files - place in config/salt_templates/solr-conf
#solr:
#  conf: salt://solr-conf

# Define nginx template
{% include 'nginx/drupal.sls' %}

# include Yeoman generated settings
include:
  - generated
