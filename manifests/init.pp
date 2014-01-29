# == Class: aide
#
# Full description of class aide here.
#
#
class aide {

    package { 'aide':
        ensure => present,
        notify => Exec['build-aide-db'],
    }

    # Do the initial build of the aide DB
    exec { 'build-aide-db':
        refreshonly => true,
        command => '/usr/sbin/aide --init',
        timeout => 0,
        notify => Exec['make-aide-db-live'],
    }

    # Make the aide live for comparison later after initial build
    exec { 'make-aide-db-live':
        refreshonly => true,
        command => '/bin/cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz',
    }

    file { "/etc/aide.conf":
        source => "puppet:///modules/aide/aide.conf",
        ensure => file,
        owner => 'root',
        group => 'root',
        mode => 0644,
    }

    file { "/etc/cron.daily/aide.cron":
        source => "puppet:///modules/aide/aide.cron",
        ensure => file,
        owner => 'root',
        group => 'root',
        mode => 0755,
    }
}
