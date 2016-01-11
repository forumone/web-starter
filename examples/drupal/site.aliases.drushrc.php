<?php

// Figure out where the vagrant private key is stored (it moved in a recent Vagrant version)
$local_root = drush_get_context('DRUSH_SELECTED_DRUPAL_ROOT');
$new_keyfile_path =  $local_root . '/../.vagrant/machines/default/virtualbox/private_key';
if (is_file($new_keyfile_path)) {
  $insecure_private_key = $new_keyfile_path;
}
else {
  $insecure_private_key = '~/.vagrant.d/insecure_private_key';
}

$aliases['local'] = array(
  'parent' => '@parent',
  'uri' => 'http://10.11.12.14',
  'root' => '/vagrant/public',
  'remote-host' => '10.11.12.14',
  'remote-user' => 'vagrant',
  'ssh-options' => "-i " . $insecure_private_key . " -l vagrant",
  'db-url' => 'mysql://web:web@10.11.12.14:3306/web',
  'databases' => array (
    'default' => array (
      'default' => array (
        'database' => 'web',
        'username' => 'web',
        'password' => 'web',
        'host' => '10.11.12.14',
        'port' => '',
        'driver' => 'mysql',
        'prefix' => '',
      ),
    ),
  ),
);

$aliases['dev'] = array(
  'uri' => 'dev.example.com',
  'root' => '/var/www/vhosts/example.dev/public',
  'remote-host' => 'dev.example.com',
  'remote-user' => 'example',
  'command-specific' => array(
    'rsync' => array ( 
      'mode' => 'rzv'
    ),
  ),  
);

$aliases['stage'] = array(
  'uri' => 'sage.example.com',
  'root' => '/var/www/vhosts/example.stage/public',
  'remote-host' => 'stage.example.com',
  'remote-user' => 'example',
  'command-specific' => array(
    'rsync' => array (
      'mode' => 'rzv'
    ),
  ),
);

$aliases['prod'] = array(
  'uri' => 'www.example.com',
  'root' => '/var/www/vhosts/example.www/public',
  'remote-host' => 'www.example.com',
  'remote-user' => 'example',
  'command-specific' => array(
    'rsync' => array (
      'mode' => 'rzv'
    ),
  ),
);

// Unset remote-host if drush command is being performed on the remote host,
// which will allow the command to work when the user doesn't have shell 
// access to itself.
// Credit: http://www.mediacurrent.com/blog/make-your-drush-aliases-work-local-and-remote
$ip = gethostbyname(php_uname('n'));
foreach ($aliases as &$alias) {
  if (empty($alias['remote-host'])) {
    continue;
  }
  if (gethostbyname($alias['remote-host']) === $ip) {
    unset($alias['remote-host']);
  }
}

