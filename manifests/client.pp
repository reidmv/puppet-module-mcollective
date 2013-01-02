define mcollective::client (
  $config_hash           = { },
  $config_filename       = "client.cfg",
  $config_directory      = "${::mcollective_confdir}",
  $config_owner          = '0',
  $config_group          = '0',
  $config_file_mode      = '0600',
  $config_directory_mode = '0700',
) {
  include mcollective::params

  $config_file = "${config_directory}/${config_filename}"

  if !defined(Package[$mcollective::params::client_package]) {
    package { $mcollective::params::client_package:
      ensure => installed,
    }
  }

  if !defined(File[$config_directory]) {
    file { $config_directory:
      ensure => directory,
      owner  => $config_owner,
      group  => $config_group,
      mode   => $config_directory_mode,
    }
  }

  file { $config_file:
    ensure => file,
    owner  => $config_owner,
    group  => $config_group,
    mode   => $config_file_mode,
  }

  $config_hash_defaults = {
    'target'  => $config_file,
    'require' => [
      Package[$mcollective::params::client_package],
      File[$config_file],
    ],
  }

  mcollective_config_hash($config_hash, $config_hash_defaults)
}
