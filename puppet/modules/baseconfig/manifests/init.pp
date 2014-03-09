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
		],
		ensure  => installed,
		require => Exec['apt-update'],
	}
}