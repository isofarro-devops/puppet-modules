#
# Nginx
#
class nginx {
	package { 'install-nginx':
		name   => 'nginx',
		ensure => installed,
	}

	service { 'nginx':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => [
			Package['nginx']
		],
	}
}