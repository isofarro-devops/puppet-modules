#
# Mysql
#
class mysql {
	package { 'mysql':
		name => [
			'mysql-client',
			'mysql-server'
		],
		ensure => installed
	}

	service { 'mysql':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => [
			Package['mysql']
		],

	}
}