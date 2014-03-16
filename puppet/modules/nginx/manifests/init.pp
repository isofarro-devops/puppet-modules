#
# Nginx
#
class nginx {
	package { 'nginx':
		name   => 'nginx',
		ensure => installed,
		require => Package['core-packages'],
	}

	service { 'nginx':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => [
			Package['nginx'],
		],
	}
}