define mcollective::stomp_failover_pool::member (
  $delimiter,
  $fallback_port,
  $fallback_user,
  $fallback_password,
  $fallback_ssl,
) {
  $arg = split($title, $delimiter)

  mcollective_setting {
    "plugin.stomp.pool.host${arg[5]}": value => $arg[0];
    "plugin.stomp.pool.port${arg[5]}": value => $arg[1] ? {
      default => $arg[1],
      ''      => $fallback_port,
    };
    "plugin.stomp.pool.user${arg[5]}": value => $arg[2] ? {
      default => $arg[2],
      ''      => $fallback_user,
    };
    "plugin.stomp.pool.password${arg[5]}": value => $arg[3] ? {
      default => $arg[3],
      ''      => $fallback_password,
    };
    "plugin.stomp.pool.ssl${arg[5]}": value => $arg[4] ? {
      default => $arg[4],
      ''      => $fallback_ssl,
    };
  }
}
