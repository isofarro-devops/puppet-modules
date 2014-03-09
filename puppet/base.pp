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
		'php-pear',
		#'phpunit',
	],
	ensure  => installed,
	require => Package['core-packages'],
}

exec { 'update-pear':
	command => '/usr/bin/pear upgrade PEAR',
	user    => 'root',
	require => Package['php5-baseline'],
}

exec { 'download-phpunit':
	creates => '/tmp/phpunit.phar',
	command => '/usr/bin/wget -O /tmp/phpunit.phar https://phar.phpunit.de/phpunit.phar',
	require => Package['php5-baseline'],

}

exec { 'install-phpunit':
	creates => '/usr/local/bin/phpunit',
	command => '/bin/cp /tmp/phpunit.phar /usr/local/bin/phpunit && /bin/chmod +x /usr/local/bin/phpunit',
	user    => 'root',
	require => Exec['download-phpunit'],
}

exec { 'install-composer':
	command => '/usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php -- --install-dir=/usr/local/bin --filename=composer',
	user    => 'root',
	require => Package['php5-baseline'],
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

