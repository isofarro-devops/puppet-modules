#
# Nginx
#
class nginx {
	package { 'nginx':
		name   => 'nginx',
		ensure => installed,
		require => Package['core-packages'],
	}

	file { 'nginx-conf-available':
		path    => '/etc/nginx/sites-available/PROJECT_NAME.dev.conf',
		source  => 'puppet:///modules/nginx/project.conf',
		ensure  => present,
		owner   => root,
		group   => root,
		mode    => 644,
		require => [
			Package['nginx']
		],
	}

	file { 'nginx-conf-enabled':
		path    => '/etc/nginx/sites-enabled/PROJECT_NAME.dev.conf',
		ensure  => link,
		target  => '/etc/nginx/sites-available/PROJECT_NAME.dev.conf',
		require => File['nginx-conf-available'],
		notify  => Service['nginx'],
	}

	service { 'nginx':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => [
			Package['nginx'],
			File['nginx-conf-enabled']
		],
	}
}