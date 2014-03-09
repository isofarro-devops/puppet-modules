# TODO: Separate into modules.

#
# Global defaults/config
#
Exec {
    path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
}


#
# Base install
#
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


#
# PHP5 environment
#
package { 'php5-baseline':
	name => [
		'php5-cli',
		'php-pear',
	],
	ensure  => installed,
	require => Package['core-packages'],
}

exec { 'update-pear':
	command => 'pear upgrade PEAR',
	user    => 'root',
	require => Package['php5-baseline'],
}

exec { 'download-phpunit':
	creates => '/tmp/phpunit.phar',
	command => 'wget -O /tmp/phpunit.phar https://phar.phpunit.de/phpunit.phar',
	require => Package['php5-baseline'],

}

exec { 'install-phpunit':
	creates => '/usr/local/bin/phpunit',
	command => 'cp /tmp/phpunit.phar /usr/local/bin/phpunit && chmod +x /usr/local/bin/phpunit',
	user    => 'root',
	require => Exec['download-phpunit'],
}

exec { 'download-composer':
	creates => '/tmp/composer.phar',
	command => 'curl -sS https://getcomposer.org/installer | php -- --install-dir=/tmp',
	user    => 'root',
	require => Package['php5-baseline'],
}

exec { 'install-composer':
	creates => '/usr/local/bin/composer',
	command => 'cp /tmp/composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer',
	user    => 'root',
	require => Exec['download-composer'],
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

