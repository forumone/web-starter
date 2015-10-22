---
layout: default
title: Customization Scenarios
---

This covers some basic scenarios to customize the particular
installation of the Web Starter Kit. Each scenario will contain a set of
steps and then what the expected outcome would be.

### Create new Host

In this scenario we'll be creating a new host file from one of the
existing host files.

#### Steps

1.  Copy puppet/manifests/hieradata/hosts/f1dev.yaml to
    puppet/manifests/hieradata/hosts/test.yaml
2.  Edit puppet/manifests/init.pp
3.  Change line 2 to `$host = 'test'`
4.  Run

        vagrant provision

#### Outcome

The provisioner should run without errors and make no changes.

### Add post-provisioner

In this scenario we'll be adding and configuring a post provision script
to set initial files for Drupal.

#### Steps

1.  Create public/sites and public/sites/default directories
2.  Copy examples/drupal/settings.vm.php to
    public/sites/default/settings.vm.php
3.  Copy examples/drupal/site.aliases.drushrc.php to
    test.aliases.drushrc.php
4.  Copy puppet/shell/custom/example-drupal-post-provision.sh to
    puppet/shell/custom/post-provision.sh
5.  Run

        vagrant provision

#### Outcome

Run `vagrant ssh` and then `ll ~/.drush` and verify there are files
there for drush.ini and test.aliases.drushrc.php. Also verify there is
/vagrant/public/sites/default/settings.php file.

### Change web server

In this scenario we'll be changing the web server on the virtual
machine.

#### Steps

1.  Edit puppet/manifests/hieradata/hosts/test.yaml
2.  Change line 8 to `forumone::webserver::webserver: "apache"`
3.  Run `vagrant provision`

#### Outcome

The response headers should indicate that you are on Apache, you can
check this with `curl -I http://localhost:8080` or by going to that URL
in a browser and inspecting the response headers.

### Add a database

In this scenario we'll be adding a new database. In the
forumone::databases stanza the key of the hash is the name of the
database and it takes a username attribute and an optional password
attribute. If the password is not specified the username is used as the
password as well.

#### Steps

1.  Edit puppet/manifests/hieradata/sites/localhost.localdomain.yaml
2.  Add entry in the forumone::databases that has:

        test: 
          username: test

3.  Run `vagrant provision`

#### Outcome

Run `vagrant ssh` and then `mysql -u test --password=test test` and
verify you are able to connect to the new database.

### Add a PHP module

In this scenario we'll be adding the PHP SOAP module.

#### Steps

1.  Edit puppet/manifests/hieradata/hosts/test.yaml
2.  Add item to array on line 12 for "soap"
3.  Run `vagrant provision`

#### Outcome

Run `vagrant ssh` and then `php -i |grep soap.wsdl_cache` and verify
that the SOAP module is installed and that the value is the default of
"1".

### Configure a PHP module

In this scenario we'll be configuring the PHP SOAP module.

#### Steps

1.  Edit puppet/manifests/hieradata/hosts/test.yaml
2.  Add and entry for php::modules so that it reads:

        php::modules: 
          xcache: 
            settings: 
              xcache.size: "96M"
          soap:
            settings:
              soap.wsdl_cache: 0

3.  Run `vagrant provision`

#### Outcome

Run `vagrant ssh` and then `php -i |grep soap.wsdl_cache` and verify
that value has been changed to "0".

### Change Solr version

In this scenario we'll be changing the version of Apache Solr from 3.6.2
to 4.8.0.

#### Steps

1.  Open a web browser and go to
    `http://localhost:18983/solr/drupal/admin` and you should see the
    admin screen for Solr 3.6.2
2.  Edit puppet/manifests/hieradata/hosts/test.yaml and add the line:

        forumone::solr::version: "4.8.0"

3.  Run `vagrant provision`

#### Outcome

After the provisioning finishes go to `http://localhost:18983/solr` you
should see a line that has "solr-spec: 4.8.0" and be able to select
"drupal" from the "Core selector" drop-down.

Note: at present there is an issue switching between versions of Solr
within the 4.x family. You can see information about the issue at
<https://github.com/forumone/web-starter/issues/27>

### Set memcached max object size

In this scenario we'll be increasing the max object size for memcached
to avoid cache failures for Drupal.

#### Steps

1.  Edit puppet/manifests/hieradata/hosts/test.yaml and add:

        memcached::options: "-I 3M"

2.  Run `vagrant provision`

#### Outcome

Run `vagrant ssh` and then `sudo service memcached restart` you should
see a warning about raising the item max size above 1MB. Run
`cat /etc/sysconfig/memcached` and verify the last line says
`OPTIONS="-I 3M"`

### Removing Varnish

In this scenario we'll be removing Varnish for a host that does not have
it.

#### Steps

1.  Edit puppet/manifests/hieradata/hosts/test.yaml and add the
    following lines:

        forumone::varnish::bind: "*:8080"
        forumone::varnish::backend_port: 80
        forumone::webserver::port: 80

2.  Remove line 3 `forumone::varnish`
3.  Run `vagrant provision`

#### Outcome

Run `curl -I "http://localhost:8080` and verify the `X-Varnish-Cache`
header is not present.

Note: due to port release issues with some web servers you may need to
run `vagrant provision` twice to have the web server properly bind to
the port.

### Adding SSH config

In this scenario we'll be adding custom SSH configuration to ensure that
connections from the VM are all using the correct user.

#### Steps

1.  Edit puppet/manifests/hieradata/sites/localhost.localdomain.yaml and
    add the following lines -- replacing server, hostname and user
    information as appropriate:

        forumone::ssh_config:
          [server]:
            hostname: [hostname]
            unix_user: "vagrant"
            port: 22
            remote_user: [user]

2.  Run `vagrant provision`

#### Outcome

Run `vagrant ssh` and `cat ~/.ssh/config` and verify that the SSH config
is in place.

### Customizing Solr config

In this scenario we'll be updating the Solr configuration files.

#### Steps

1.  Create directory structure in puppet like `puppet/files/solr/3.x`
2.  Edit puppet/manifests/hieradata/sites/localhost.localdomain.yaml and
    change the solr stanza to be like:

        forumone::solr::collections:  
          drupal: 
            order: 1
            config_directory: '/vagrant/puppet/files/solr/3.x'
            files:
              - mapping-ISOLatin1Accent.txt
              - protwords.txt
              - protwords_en.txt
              - stopwords.txt
              - elevate.xml
              - synonyms_en.txt
              - synonyms.txt
              - stopwords_en.txt
              - mapping-ISOLatin1Accent_en.txt
              - compoundwords_en.txt
              - protwords_fr.txt
              - stopwords_fr.txt
              - compoundwords_fr.txt
              - synonyms_fr.txt
              - mapping-ISOLatin1Accent_fr.txt
              - protwords_es.txt
              - stopwords_es.txt
              - compoundwords_es.txt
              - synonyms_es.txt
              - mapping-ISOLatin1Accent_es.txt
              - protwords_ar.txt
              - stopwords_ar.txt
              - compoundwords_ar.txt
              - synonyms_ar.txt
              - mapping-ISOLatin1Accent_ar.txt
              - mapping-ISOLatin1Accent.erb
              - schema_extra_fields.xml
              - schema_extra_types.xml
              - schema.xml
              - solrconfig_extra.xml
              - solrconfig.xml
              - solrcore.properties

3.  Copy and customize appropriate files. Note that all files expect to
    end with `.erb` instead of the extension above, e.g.
    `solrconfig.erb` instead of `solrconfig.xml`. All files necessary
    for the Solr collection must be placed in the directory and
    enumerated in the YAML file. These files can typically be found in
    the configuration directories for either the Search API or
    Apachesolr module.
4.  Run `vagrant provision`

#### Outcome

Run `vagrant ssh` and the new configuration should be available in
`/opt/solr`. You may need to delete and re-index Solr in order to see
the updates.

### Update drush to 8.x

#### Steps

1. Edit /puppet/manifests/hieradata/sites/localhost.localdomain.yaml

2. Add the line: forumone::drush::version: '8.0.0-rc1'

You can look up drush releases here to specify as version:
https://github.com/drush-ops/drush/releases

If you specify a git branch, re-provisioning later will *NOT* re-fetch from the repo.
You'll have to delete /opt/BRANCH-NAME.zip before re-provisioning in order to make it work.

3. Run `vagrant provision`

#### Outcome

Run `drush --version`.  You should see the release version specified.

{% include menus/localdev.md %}
