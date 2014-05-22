<?php

$aliases['local'] = array(
  'parent' => '@parent',
  'uri' => 'http://10.11.12.14',
  'root' => '/vagrant/public',
  'remote-host' => '10.11.12.14',
  'remote-user' => 'vagrant',
  'ssh-options' => "-i ~/.vagrant.d/insecure_private_key -l vagrant",
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
