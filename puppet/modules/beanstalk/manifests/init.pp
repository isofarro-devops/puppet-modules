#
# Beanstalk
#
class beanstalk {
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
}
