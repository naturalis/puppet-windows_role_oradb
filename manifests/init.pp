# == Class: windows_role_oradb
#
# Full description of class windows_role_oradb here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { windows_role_oradb:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class windows_role_oradb  (
  $installdb_hash = {'nbcprod' => { version         => '11.2.0.3',
                                    oracleHome      => 'C:/Oracle_Sys/nbcprod/product/11.2.0/db',
                                    oracleBase      => 'C:/Oracle_Sys/nbcprod',
                                    databaseType    => 'SE',
                                    #archiveFilename => 'p10404530_112030_MSWIN-x86-64',
                                    installFolder   => 'C:/Install',
                                    zipfilesFolder  => 'C:/Zipfiles',
                                  },
                    },

  $database_hash  = {'nbcprod' => { oracleBase              => 'C:/Oracle_Sys',
                                    oracleHome              => 'C:/Oracle_Sys/product/11.2.0/db',
                                    user                    => 'oracle',
                                    group                   => 'dba',
                                    downloadDir             => 'C:/Install',
                                    action                  => 'create',
                                    dbName                  => 'nbcprod',
                                    dbDomain                => 'nnm.local',
                                    sysPassword             => 'Welcome01',
                                    systemPassword          => 'Welcome01',
                                    dataFileDestination     => "/oracle/oradata",
                                    recoveryAreaDestination => "/oracle/flash_recovery_area",
                                    characterSet            => "AL32UTF8",
                                    nationalCharacterSet    => "UTF8",
                                    initParams              => "open_cursors=1000,processes=600,job_queue_processes=4,compatible=11.2.0.0.0",
                                    sampleSchema            => 'TRUE',
                                    memoryPercentage        => "40",
                                    memoryTotal             => "800",
                                    databaseType            => "MULTIPURPOSE",
                                  },
                     },

  $net_hash       = {'listener' => { oracleHome   => '/oracle/product/11.2/db',
                                     version      => '11.2',
                                     user         => 'oracle',
                                     group        => 'dba',
                                     downloadDir  => '/install',
                                   },
                    },
) {

  class {"windows_role_base":}

  class {"windows_role_oradb::installdb":
    installdb_hash => $installdb_hash,
    require        => Class['windows_role_base']
  }

  #class {"windows_role_oradb::database":
  #  database_hash => $database_hash,
  #  require       => Class['windows_role_oradb::net'],
  #}

  #class {"windows_role_oradb::net":
  #  net_hash => $net_hash,
  #  require  => [Host[$::fqdn],Class['windows_role_oradb::installdb']],
  #}

}
