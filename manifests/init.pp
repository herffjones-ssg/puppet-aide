# modules/aide/manifests/init.pp - manage aide
# Copyright (C) 2007 admin@immerda.ch
# 

class aide {

	package { 'aide':
                ensure => present,
                category => $operatingsystem ? {
                        gentoo => 'app-forensics',
                        default => '',
                },
        }


	#service { aide: ensure  => running, enable  => true, }

	file {
        	"/etc/aide/aide.conf":
                source => "puppet://$servername/aide/aide.conf",
        		ensure => file,
        		force => true,
        		mode => 0644, owner => root, group => 0;
        }
	file {
        	"/etc/cron.daily/aide.cron":
                source => "puppet://$servername/aide/aide.cron",
        	    ensure => file,
        	    force => true,
        	    mode => 0755, owner => root, group => 0;
        }
	file {
        	"/var/lib/aide/aide.db":
                source => [
                    "puppet://$servername/dist/apps/aide/${fqdn}/aide.db",
                    "puppet://$servername/dist/apps/aide/immer1-0.glei.ch/aide.db"
                ],
        	    ensure => file,
        	    force => true,
                mode => 0400, owner => root, group => 0;
        }
}

