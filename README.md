# MCollective Puppet Module #

## Examples ##

    class { 'mcollective::server':
      config_hash => {
        'connector'              => 'stomp',
        'plugin.stomp.base64'    => 'true',
        'plugin.stomp.pool.size' => '1',
      },
    }

    mcollective_setting { 'plugin.stomp.pool.host1': value => 'master'      }
    mcollective_setting { 'plugin.stomp.pool.port1': value => '61613'       }
    mcollective_setting { 'plugin.stomp.pool.user1': value => 'mcollective' }
    mcollective_setting { 'plugin.stomp.pool.ssl1':  value => 'true'        }

    mcollective_setting { 'Verbose resource title for password':
      name  => 'plugin.stomp.pool.password1',
      value => 'passw0rd',
    }
