VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "forumone/centos66-64-salt"

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box

    # If you are using VirtualBox, you might want to use that to enable NFS for
    # shared folders. This is also very useful for vagrant-libvirt if you want
    # bi-directional sync
    config.cache.synced_folder_opts = {
      type: :nfs,
      # The nolock option can be useful for an NFSv3 client that wants to avoid the
      # NLM sideband protocol. Without this option, apt-get might hang if it tries
      # to lock files needed for /var/cache/* operations. All of this can be avoided
      # by using NFSv4 everywhere. Please note that the tcp option is not the default.
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # Varnish
  config.vm.network :forwarded_port, guest: 80, host: 8080
  # Nginx / Apache
  config.vm.network :forwarded_port, guest: 8080, host: 8081
  # Solr
  config.vm.network :forwarded_port, guest: 8983, host: 18983
  # MySQL
  config.vm.network :forwarded_port, guest: 3306, host: 13306
  # MailHog
  config.vm.network :forwarded_port, guest: 8025, host: 8025
  
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "10.11.12.14"

  # Add NFS
  if (RUBY_PLATFORM =~ /linux/ or RUBY_PLATFORM =~ /darwin/)
    config.vm.synced_folder ".", "/vagrant", :nfs => { :mount_options => ["dmode=777","fmode=666"] }
    config.vm.synced_folder "./salt/roots/", "/srv/salt", :nfs => { }
    config.nfs.map_uid = Process.uid
    config.nfs.map_gid = Process.gid
  else
    config.vm.synced_folder ".", "/vagrant", :mount_options => [ "dmode=777","fmode=666" ]
    config.vm.synced_folder "./salt/roots/", "/srv/salt", :mount_options => [ "dmode=777","fmode=666" ]
    config.nfs.map_uid = 501
    config.nfs.map_gid = 20
  end

  
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  
  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1736"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.ssh.forward_agent = true

  # Run any custom scripts before provisioning
  config.vm.provision :shell, :path => "puppet/shell/pre-provision.sh"

  # Salt provisioning
  config.vm.provision :salt do |salt|
#    salt.bootstrap_options = "-X -p python-pygit2 -p GitPython -p git"
    salt.minion_config = "salt/minion"
    salt.masterless = true
    salt.verbose = true
    salt.colorize = true
    salt.log_level = 'info'
    salt.run_highstate = true
  end

#  config.vm.provision "shell",
#    inline: "sudo cp /vagrant/salt/minion /etc/salt/minion && sudo salt-call state.sls jinja26 && sudo bash -c 'export PYTHONPATH=/usr/lib/python2.6/site-packages/Jinja2-2.6-py2.6.egg:$PYTHONPATH; salt-call state.highstate && sudo yum -y update'"

  # Run any custom scripts after provisioning
  config.vm.provision :shell, :path => "puppet/shell/post-provision.sh"

  # https://github.com/mitchellh/vagrant/issues/5001
  config.vm.box_download_insecure = true

end

overrides = "#{__FILE__}.local"
if File.exist?(overrides)
   eval File.read(overrides)
end
