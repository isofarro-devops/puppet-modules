#
# Base install
#
class baseconfig {
	exec { 'apt-update':
		command => 'apt-get update',
		user    => 'root',
	}

	package { 'core-packages':
		name => [
			'wget',
			'curl',
			'vim',
			'git-core',
			'htop',
			'sqlite3',
		],
		ensure  => installed,
		require => Exec['apt-update'],
	}
}