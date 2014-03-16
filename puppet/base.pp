#
# Global defaults/config
#
Exec {
    path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
}


#
# Modules
#

# Base Ubuntu packages and configuration
include baseconfig

# Mysql client and server
include mysql

# Nginx web server
include nginx

# PHP install - for command line use
include php

# Beanstalk message queue
include beanstalk



#
# Project specific config
#

# symlink project's nginx config
file { 'nginx-project-available':
	name    => '/etc/nginx/sites-available/PROJECT_NAME.dev',
	ensure  => 'link',
	target  => '/home/vagrant/PROJECT_NAME/etc/conf/nginx.conf',
	require => Package['nginx'],
}

file { 'nginx-project-enabled':
	name    => '/etc/nginx/sites-enabled/PROJECT_NAME.dev',
	ensure  => 'link',
	target  => '/home/vagrant/PROJECT_NAME/etc/conf/nginx.conf',
	require => File['nginx-project-available'],
	notify  => Service['nginx']
}
