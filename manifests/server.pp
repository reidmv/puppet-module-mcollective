class mcollective::server (
  $ensure            = present,
  $config_hash       = { },
  $config_file       = "${::mcollective_confdir}/server.cfg"
  $config_file_owner = undef,
  $config_file_group = undef,
  $config_file_mode  = undef,
) {
  include mcollective::params

  validate_hash($config_hash)

  package { $mcollective::params::server_package:
    ensure => $ensure,
  }

  file { $config_file:
    ensure => present,
    owner  => $config_file_owner,
    group  => $config_file_group,
    mode   => $config_file_mode,
  }

  service { $mcollective::params::server_service:
    ensure  => running,
    enable  => true,
    require => Package[$mcollective::params::server_package],
  }

  $config_hash_defaults = {
    'require' => Package[$mcollective::params::server_package],
    'target'  => $config_file,
  }

  mcollective_config_hash($config_hash, $config_hash_defaults)
}
