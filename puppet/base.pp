#
# Global defaults/config
#
Exec {
    path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
}

# Project variables
$projectName   = 'PROJECT_NAME'
$projectDir    = "/home/vagrant/${projectName}"
$projectDomain = "project_name.dev"


#
# Modules: what does your project need?
#

# Base Ubuntu packages and configuration
include baseconfig

# Mysql client and server
include mysql

# Nginx web server
include nginx

# PHP install: CLI and FPM
include php

# Beanstalk message queue (optional)
#include beanstalk



#
# Project specific config
#

# symlink project's nginx config
file { 'nginx-project-available':
	name    => "/etc/nginx/sites-available/${projectDomain}",
	ensure  => 'link',
	target  => "${projectDir}/etc/conf/nginx.conf",
	require => Package['nginx'],
}

file { 'nginx-project-enabled':
	name    => "/etc/nginx/sites-enabled/${projectDomain}",
	ensure  => 'link',
	target  => "/etc/nginx/sites-available/${projectDomain}",
	require => File['nginx-project-available'],
	notify  => Service['nginx']
}
