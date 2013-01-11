# Other related options to manage, can be done with mcollective_setting
# resource. Options listed with their defaults.
#
# initial_reconnect_delay  = 0.01
# max_reconnect_delay      = 30.0
# use_exponential_back_off = true
# back_off_multiplier      = 2
# max_reconnect_attempts   = 0
# randomize                = false
# timeout                  = -1
# connect_timeout          = 30
#
class mcollective::stomp_failover_pool (
  $host,
  $port,
  $user,
  $password,
  $ssl,
  $delimiter = undef,
) {

  if is_array($host) { $host_array = $host }
  elsif $delimiter { $host_array = split($host, $delimiter) }
  else { $host_array = [$host] }

  if is_array($port) { $port_array = $port }
  elsif $delimiter { $port_array = split($port, $delimiter) }
  else { $port_array = [$port] }

  if is_array($user) { $user_array = $user }
  elsif $delimiter { $user_array = split($user, $delimiter) }
  else { $user_array = [$user] }

  if is_array($password) { $password_array = $password }
  elsif $delimiter { $password_array = split($password, $delimiter) }
  else { $password_array = [$password] }

  if is_array($ssl) { $ssl_array = $ssl }
  elsif $delimiter { $ssl_array = split($ssl, $delimiter) }
  else { $ssl_array = [$ssl] }

  $array_size = size($host_array)
  $index      = range('1', $array_size)
  $zipdelim   = ','

  $records = zipjoin($zipdelim,
    $host_array,
    $port_array,
    $user_array,
    $password_array,
    $ssl_array,
    $index
  )

  mcollective_setting { 'plugin.stomp.pool.size': value => $array_size }

  mcollective::stomp_failover_pool::member { $records:
    delimiter         => $zipdelim,
    fallback_port     => $port_array[0],
    fallback_user     => $user_array[0],
    fallback_password => $password_array[0],
    fallback_ssl      => $ssl_array[0],
  }

}
