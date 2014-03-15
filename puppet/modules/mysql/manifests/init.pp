#
# Mysql
#
class mysql {
	package { 'mysql':
		name => [
			'mysql-client',
			'mysql-server'
		],
		ensure => installed,
		require => Package['core-packages'],
	}


	file { '/var/lib/mysql/my.cnf':
		owner   => 'mysql',
		group   => 'mysql',
		source  => 'puppet:///modules/mysql/my.cnf',
		notify  => Service['mysql'],
		require => Package['mysql']
	}


	file { '/etc/my.cnf':
		require => File['/var/lib/mysql/my.cnf'],
		ensure  => '/var/lib/mysql/my.cnf'
	}


	exec { 'set-mysql-password':
		unless => 'mysqladmin -uroot -prootpwd status',
		command => 'mysqladmin -uroot password rootpwd',
		path   => ['/bin', '/usr/bin'],
		require => [
			Package['mysql'],
		]
	}


	service { 'mysql':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => [
			Package['mysql'],
		],

	}
}