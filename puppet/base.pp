# TODO: Separate into modules.


#
# Base install
#
exec { 'aptupdate':
	command => '/usr/bin/apt-get update',
	user    => 'root',
}

package { 'core-packages':
	name => [
		'wget',
		'vim',
		'git-core',
		'htop',
	],
	ensure  => installed,
	require => Exec['aptupdate'],
}