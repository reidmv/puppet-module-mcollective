# MCollective Puppet Module #

## Examples ##

    # Class
    class { 'mcollective::server':
      config_hash => {
        'connector'           => 'stomp',
        'plugin.stomp.base64' => 'true',
      },
    }

    # Setting, Verbose
    mcollective_setting { 'Verbose resource title for resource':
      name  => 'plugin.stomp.pool.initial_reconnect_delay',
      value => '0.01',
    }

    # Settings, abbreviated
    $pool = 'plugin.stomp.pool'
    mcollective_setting { "$pool.max_reconnect_delay":      value => '30.0'  }
    mcollective_setting { "$pool.use_exponential_back_off": value => 'true'  }
    mcollective_setting { "$pool.back_off_multiplier":      value => '2'     }
    mcollective_setting { "$pool.max_reconnect_attempts":   value => '0'     }

    # Settings, even more abbreviated
    mcollective_setting { "$pool.randomize = false":    }
    mcollective_setting { "$pool.timeout = -1":         }
    mcollective_setting { "$pool.connect_timeout = 30": }

    # Failover Pool Configuration
    class { 'mcollective::stomp_failover_pool':
      host     => [ 'firefly.example.com', 'serenity.example.com' ],
      port     => '6163',
      user     => [ 'icanhazuser', 'usercanihaz' ],
      password => [ 'passw0rdz', 'w0rdofpassing' ],
      ssl      => true,
    }
