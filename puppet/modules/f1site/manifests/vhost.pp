define f1site::vhost (
	$path 		= '/vagrant/public',
){
    file { $path:
        ensure => directory,
    }

	apache::vhost { 'localhost':
		port    		=> '80',
		docroot 		=> $path,
		directories => [ { path => $path, allow_override => ['All'] } ]
	}
}
