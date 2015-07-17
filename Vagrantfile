Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "forumone/centos64-64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://boxen.forumone.com/centos64-64.box"

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
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 443, host: 443
  config.vm.network :forwarded_port, guest: 8080, host: 8081
  config.vm.network :forwarded_port, guest: 8983, host: 18983
  config.vm.network :forwarded_port, guest: 3306, host: 13306
  config.vm.network :forwarded_port, guest: 1080, host: 1080
  
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "10.11.12.14"

  # Add NFS
  if (RUBY_PLATFORM =~ /linux/ or RUBY_PLATFORM =~ /darwin/)
    config.vm.synced_folder ".", "/vagrant", :nfs => { :mount_options => ["dmode=777","fmode=666","no_root_squash"] }
    config.nfs.map_uid = Process.uid
    config.nfs.map_gid = Process.gid
  else
    config.vm.synced_folder ".", "/vagrant", :mount_options => [ "dmode=777","fmode=666" ]
    config.nfs.map_uid = 501
    config.nfs.map_gid = 20
  end
  
  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1736"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.ssh.forward_agent = true

  # Run any custom scripts before provisioning
  config.vm.provision :shell, :path => "puppet/shell/pre-provision.sh"

  # Install git and librarian-puppet and get puppet modules
  config.vm.provision :shell, :path => "puppet/shell/librarian-puppet-install.sh"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file centos64-64.pp in the manifests_path directory.
  config.vm.provision :puppet do |puppet|
    puppet.options = "--verbose"
    puppet.facter = { 
      "host_uid" => config.nfs.map_uid, 
      "host_gid" => config.nfs.map_gid, 
      "vagrant_user" => ENV['USER'] }
    
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "init.pp"
    puppet.hiera_config_path = "puppet/manifests/hiera.yaml"
  end

  # Run any custom scripts after provisioning
  config.vm.provision :shell, :path => "puppet/shell/post-provision.sh"

end

overrides = "#{__FILE__}.local"
if File.exist?(overrides)
   eval File.read(overrides)
end
