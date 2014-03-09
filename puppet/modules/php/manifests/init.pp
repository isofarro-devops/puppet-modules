#
# PHP5 environment
#
class php {
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
}