define mcollective::client (
  $config_hash       = { },
  $config_file       = "${::mcollective_confdir}/client.cfg",
  $config_file_owner = undef,
  $config_file_group = undef,
  $config_file_mode  = undef,
) {
  include mcollective::params

  if !defined(Package[$mcollective::params::client_package]) {
    package { $mcollective::params::client_package:
      ensure => installed,
    }
  }

  file { $config_file:
    ensure => present,
    owner  => $config_file_owner,
    group  => $config_file_group,
    mode   => $config_file_mode,
  }

  $config_hash_defaults = {
    'require' => Package[$mcollective::params::client_package],
    'target'  => $config_file,
  }

  mcollective_config_hash($config_hash, $config_hash_defaults)
}
