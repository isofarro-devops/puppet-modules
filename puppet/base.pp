# TODO: Separate into modules.


#
# Base install
#
exec { 'apt-update':
	command => '/usr/bin/apt-get update',
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


#
# PHP5 environment
#
package { 'php5-baseline':
	name => [
		'php5-cli',
		'phpunit',
	],
	ensure  => installed,
	require => Package['core-packages'],
}


#
# Beanstalk
#
package { 'beanstalkd':
	ensure  => installed,
	require => Package['core-packages'],
}

file { 'beanstalkd-config':
	path    => '/etc/default/beanstalkd',
	ensure  => present,
	source  => 'puppet:///modules/beanstalk/beanstalkd.conf',
	owner   => 'root',
	group   => 'root',
	mode    => '644',
	notify  => Service['beanstalkd'],
	require => Package['beanstalkd'],
}

service { 'beanstalkd':
	ensure     => running,
	enable     => true,
	hasrestart => true,
	hasstatus  => true,
	require    => [
		Package['beanstalkd'],
		File['beanstalkd-config'],
	],
}

