Facter.add("mcollective_confdir") do
  setcode do
    case Facter['puppetversion'].value.include?('Puppet Enterprise')
    when true
      '/etc/puppetlabs/mcollective'
    when false
      '/etc/mcollective'
    else
      nil
    end
  end
end
