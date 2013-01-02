class mcollective::params {

  $server_config_file = "${::mcollective_confdir}/server.cfg"

  if $::puppetversion =~ /Puppet Enterprise/ {
    $server_package = 'pe-mcollective'
    $client_package = 'pe-mcollective-client'
    $server_service = 'pe-mcollective'
  } else {
    $server_package = 'mcollective'
    $client_package = 'mcollective-client'
    $server_service = 'mcollective'
  }

  $server_user  = 'root'
  $server_group = 'root'
  $server_config_file_mode      = '0600'
  $server_config_directory_mode = '0700'

}
