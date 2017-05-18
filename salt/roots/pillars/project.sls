# Define nginx template
include:
  - nginx.drupal8:
      defaults:
        document_root: /vagrant/public
  
# Extra packages to install
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

# To modify php.ini settings, uncomment section and add values below
#php:
#  ng:
#    cli:
#      ini:
#        settings:
#          PHP:
#            memory_limit: 256M

# Elasticsearch config example for version 5.2.2
#elasticsearch:
#  version: 5.2.2
#  config:
#    http.cors.enabled: true
#    network.bind_host: 0.0.0.0
#    bootstrap.system_call_filter: false
#  sysconfig:
#    JAVA_HOME: /usr/lib/java
#    MAX_OPEN_FILES: 65536
#  jvm_opts:
## Set Smaller memory footprint, followed by defaults
#    - -Xms512m
#    - -Xms512m
#    - -XX:ParallelGCThreads=1
#    - -Dfile.encoding=UTF-8
#    - -Dio.netty.noKeySetOptimization=true
#    - -Dio.netty.noUnsafe=true
#    - -Dio.netty.recycler.maxCapacityPerThread=0
#    - -Djava.awt.headless=true
#    - -Djdk.io.permissionsUseCanonicalPath=true
#    - -Djna.nosys=true
#    - -Dlog4j2.disable.jmx=true
#    - -Dlog4j.shutdownHookEnabled=false
#    - -Dlog4j.skipJansi=true
#    - -server
#    - -Xss1m
#    - -XX:+AlwaysPreTouch
#    - -XX:CMSInitiatingOccupancyFraction=75
#    - -XX:+DisableExplicitGC
#    - -XX:+HeapDumpOnOutOfMemoryError
#    - -XX:+UseCMSInitiatingOccupancyOnly
#    - -XX:+UseConcMarkSweepGC
