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
  $installdb_hash = {'nbcprod' => { # General
                                    version        => '11.2.0.3',
                                    #archiveFilename => 'p10404530_112030_MSWIN-x86-64',
                                    installFolder  => 'C:/Install',
                                    zipfilesFolder => 'C:/Zipfiles',

                                    # Responsefile
                                    oracleHome     => 'C:\Oracle_Sys\nbcprod\product\11.2\db',
                                    oracleBase     => 'C:\Oracle_Sys\nbcprod',
                                    databaseType   => 'SE',
                                  },
                    },

  $database_hash  = {'nbcprod' => { # General
                                    oracleHome     => 'C:\Oracle_Sys\nbcprod\product\11.2\db',
                                    oracleBase     => 'C:\Oracle_Sys\nbcprod',
                                    version        => '11.2.0.3',
                                    installFolder  => 'C:/Install',

                                    # Reponsefile
                                    globalDbName   => 'nbcprod',
                                    dbName         => 'nbcprod',
                                    templateName   => 'nbcprod.dbt',
                                    sysPassword    => 'Passw0rd',
                                    systemPassword => 'Passw0rd',
                                  },
                     },

  $net_hash       = {'listener_nbcprod' => { oracleHome        => 'C:\Oracle_Sys\nbcprod\product\11.2\db',
                                             oracleBase        => 'C:\Oracle_Sys\nbcprod',
                                             version           => '11.2.0.3',
                                             installFolder     => 'C:/Install',
                                             
                                             # Reponsefile
                                             installType       => 'custom', # "typical","minimal" or "custom", set to custom if using port other than 1521
                                             listenerProtocols => 'TCP;1523',
                                             nsnProtocols      => 'TCP;HOSTNAME;1523',
                                           },
                    },
) {

  stage {'pre':
  }

  Stage['pre'] -> Stage['main']

  class {"windows_role_base":
    stage => 'pre',
  }
  
  class {"windows_role_oradb::installdb":
    installdb_hash => $installdb_hash,
  }

  class {"windows_role_oradb::database":
    database_hash => $database_hash,
    require       => Class['windows_role_oradb::installdb'],
  }

  class {"windows_role_oradb::net":
    net_hash => $net_hash,
    require  => Class['windows_role_oradb::database'],
  }

}
