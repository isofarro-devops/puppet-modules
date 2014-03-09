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

