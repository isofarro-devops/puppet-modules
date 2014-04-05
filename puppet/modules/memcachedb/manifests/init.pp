#
# Memcachedb - document store (uses BerkeleyDb)
#
class memcachedb {
    package { 'memcachedb':
        ensure  => installed,
        require => Package['core-packages'],
    }

    service { 'memcachedb':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => [
            Package['memcachedb'],
        ],
    }
}
