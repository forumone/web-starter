---
title: Virtual Machine Options
---

The Vagrantfile comes with a set of configuration that are generally
reasonable to develop locally. These include the following.

#### Vagrant cachier

If the [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier)
plugin is available it will be mounted and used to speed up package
downloads as well as Solr downloads.

Note: that in some cases there may be challenges installing
vagrant-cachier due to interference with other gems. More information
may be found at <https://github.com/mitchellh/vagrant/issues/3794>.

#### Networking

The following ports are mapped by default:

-   80 &lt;=&gt; 8080 -- used for Varnish if installed, or the web
    server
-   8080 &lt;=&gt; 8081 -- used for direct access to the web server if
    Varnish is installed
-   8983 &lt;=&gt; 18983 -- used to access to the Solr admin panel
-   3306 &lt;=&gt; 13306 -- used to access to MySQL
-   1080 &lt;=&gt; 1080 -- used to access the Mailcatcher UI

The VM is set to use private networking with a default IP address of
`10.11.12.14`. Note: using private networking in this fashion will not
allow multiple VMs with these settings to be run concurrently. SSH agent
forwarding is also enabled by default.

#### File sharing

NFS is enabled for Linux and Macintosh OS X operating systems. It mounts
the root directory of the project to `/vagrant` on the virtual machine.
The NFS UID and GID are set to the UID and GID of the user who runs
vagrant.

#### Resources

By default the VM is set to use 1736M of memory. This is set to avoid
the typical 512M memory setting in Virtualbox. This can be overridden by
[Local Overrides](#localoverrides)

#### Provisioning

There are a number of provisioning steps that are taken when loading a
Web Starter Kit virtual machine. There are shell scripts in
`puppet/shell` that are intended to be relatively static with
per-project custom scripts in `puppet/shell/custom`. In addition Puppet
is used to handle the majority of VM configuration.

-   A shell script that is run before any other provisioners at
    `puppet/shell/pre-provision.sh` that at present only triggers a
    custom script at `puppet/shell/custom/pre-provision.sh`
-   A shell script that installs librarian-puppet and dependencies on
    the VM at `puppet/shell/librarian-puppet-install.sh`
-   Puppet provisioning, the following variables are injected via Facter
    and available:
    -   host\_uid: the UID of the user running the vagrant process
    -   host\_gid: the GID of the user running the vagrant process
    -   vagrant\_user: the username of the user running the vagrant
        process
-   A shell script that runs bundler, NPM and bower if their
    configuration files exist at `puppet/shell/post-provision.sh`; it
    also runs a custom shell script in
    `puppet/shell/custom/post-provision.sh` if it exists; this is
    generally used to copy settings files and do other setup on a
    per-project basis

### Local Overrides

Because the Vagrantfile is intended to be versioned all team members
will have the same configuration for their virtual machine. However in
some cases different team members need to be able to adjust these
settings, generally to account for different resources available on
their machine. If it exists a `Vagrantfile.local` is included after the
normal configuration. Since it's included last settings defined there
will override the ones in the main Vagrantfile. For example, to reduce
the memory usage of the VM to 1024M you would create a Vagrantfile.local
with the following: {% gist wwhurley/6194718f37318224ae5c %} The
`.gitignore` file will prevent this from being included in the
repository.
