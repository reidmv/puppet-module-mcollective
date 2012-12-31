# MCollective Puppet Module #

## Examples ##

    mcollective_setting { 'example setting':
      name  => 'connector',
      value => 'stomp',
    }

    mcollective_setting { 'verbose title':
      name  => 'plugin.stomp.pool.size',
      value => '1',
    }

    mcollective_setting { 'plugin.stomp.pool.host1':     value => 'master'      }
    mcollective_setting { 'plugin.stomp.pool.port1':     value => '61613'       }
    mcollective_setting { 'plugin.stomp.pool.user1':     value => 'mcollective' }
    mcollective_setting { 'plugin.stomp.pool.password1': value => 'password'    }
    mcollective_setting { 'plugin.stomp.pool.ssl1':      value => 'true'        }
    mcollective_setting { 'plugin.stomp.base64':         value => 'true'        }
