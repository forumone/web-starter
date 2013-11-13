class f1site::ruby (
  $ruby = "1.9.3-p448",
  $user = "vagrant",
  $group = "vagrant",
) {
  rbenv::plugin::rbenvvars { $user:
    user  => $user,
    group => $group,
    home  => "/home/${user}",
    root  => "/home/${user}/.rbenv"
  }

  rbenv::install { $user:
    user => $user,
    group => $group,
    home  => "/home/${user}",
    root => "/home/${user}/.rbenv"
  }

  rbenv::compile { $ruby:
    user => $user,
    group => $group,
    home => "/home/${user}",
    root => "/home/${user}/.rbenv"
  }

#  rbenv::client { "vagrant":
#    user => "vagrant",
#    home => "/home/vagrant",
#    ruby => "1.9.3-p448",
#    owner => "vagrant",
#    source => "/home/vagrant"
#  }  

  file { "/home/${user}/Gemfile":
    ensure  => present,
    path    => "/home/${user}/Gemfile",
    owner   => $user,
    group   => $group,
    content => file('/vagrant/Gemfile'),
    backup  => false,
  }
  
  exec {"${user} bundle":
    command   => "bundle",
    cwd       => "/vagrant",
    user      => $user,
    group     => $group,
    path      => "/home/${user}/bin:/home/${user}/.rbenv/shims:/bin:/usr/bin",
    creates   => "/vagrant/Gemfile.lock",
    subscribe => File["/home/${user}/Gemfile"],
    require   => Rbenvgem["${user}/${ruby}/bundler/present"]
  }
}
