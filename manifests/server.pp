class mcollective::server (
  $ensure                = present,
  $config_hash           = { },
  $config_filename       = "server.cfg",
  $config_directory      = "${::mcollective_confdir}",
  $config_owner          = $mcollective::params::server_user,
  $config_group          = $mcollective::params::server_group,
  $config_file_mode      = $mcollective::params::server_config_file_mode,
  $config_directory_mode = $mcollective::params::server_config_directory_mode,
) inherits mcollective::params {

  validate_hash($config_hash)
  $config_file = "${config_directory}/${config_filename}"

  package { $mcollective::params::server_package:
    ensure => $ensure,
  }

  file { $config_file:
    ensure  => present,
    owner   => $config_owner,
    group   => $config_group,
    mode    => $config_file_mode,
    require => Package[$mcollective::params::server_package],
  }

  service { $mcollective::params::server_service:
    ensure    => running,
    enable    => true,
    subscribe => File[$config_file],
  }

  $config_hash_defaults = {
    'target'  => $config_file,
    'require' => [
      Package[$mcollective::params::server_package],
      File[$config_file],
    ],
  }

  mcollective_config_hash($config_hash, $config_hash_defaults)
}
