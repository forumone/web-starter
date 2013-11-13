class forumone::ruby (
) {
  rbenv::plugin::rbenvvars { $::forumone::ruby_user:
    user  => $::forumone::ruby_user,
    group => $::forumone::ruby_group,
    home  => "/home/${::forumone::ruby_user}",
    root  => "/home/${::forumone::ruby_user}/.rbenv"
  }

  rbenv::install { $::forumone::ruby_user:
    user => $::forumone::ruby_user,
    group => $::forumone::ruby_group,
    home  => "/home/${::forumone::ruby_user}",
    root => "/home/${::forumone::ruby_user}/.rbenv"
  }

  rbenv::compile { $::forumone::ruby_version:
    user => $::forumone::ruby_user,
    group => $::forumone::ruby_group,
    home => "/home/${::forumone::ruby_user}",
    root => "/home/${::forumone::ruby_user}/.rbenv"
  }

  file { "/home/${::forumone::ruby_user}/Gemfile":
    ensure  => present,
    path    => "/home/${::forumone::ruby_user}/Gemfile",
    owner   => $::forumone::ruby_user,
    group   => $::forumone::ruby_group,
    content => file('/vagrant/Gemfile'),
    backup  => false,
  }
  
  exec {"${::forumone::ruby_user} bundle":
    command   => "bundle",
    cwd       => "/vagrant",
    user      => $::forumone::ruby_user,
    group     => $::forumone::ruby_group,
    path      => "/home/${::forumone::ruby_user}/bin:/home/${::forumone::ruby_user}/.rbenv/shims:/bin:/usr/bin",
    creates   => "/vagrant/Gemfile.lock",
    subscribe => File["/home/${::forumone::ruby_user}/Gemfile"],
    require   => Rbenvgem["${::forumone::ruby_user}/${::forumone::ruby_version}/bundler/present"]
  }
}
