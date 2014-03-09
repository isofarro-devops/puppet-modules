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

# PHP install - for command line use
include php

# Beanstalk message queue
include beanstalk

