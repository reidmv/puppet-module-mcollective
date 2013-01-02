Puppet::Type.newtype(:mcollective_setting) do
  @doc = "Manage key-value settings for mcollective"

  ensurable

  newparam(:name) do
    desc "The name"
    isnamevar
  end

  newproperty(:target) do
    desc "The configuration file in which to place settings"
    defaultto do
      File.join(Facter.value('mcollective_confdir'), 'server.cfg')
    end
  end

  newproperty(:value) do
    desc "The value to give the configuration key"
  end

  newproperty(:comment) do
    desc "The comment to give the configuration key"
  end

end
