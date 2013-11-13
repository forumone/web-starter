class f1site::drush {
  package { 'php-pear': }

  pear { "Console_Table":
    package     => "Console_Table",
    creates     => "/usr/share/php/test/Console_Table",
    require     => Package['php-pear'],
  }

  pear { "drush":
    package     => "drush/drush",
    creates     => "/usr/bin/drush",
    channel     => "pear.drush.org",
  }

  pear { "Archive_Tar":
    package     => "Archive_Tar",
    creates     => "/usr/share/doc/php5-common/PEAR/Archive_Tar",
    require     => Package['php-pear'],
  }
}