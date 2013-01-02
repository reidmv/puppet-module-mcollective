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

}
