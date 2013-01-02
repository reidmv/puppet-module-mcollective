Puppet::Parser::Functions::newfunction(
  :mcollective_config_hash,
  :doc => 'Create an mcollective_setting resource for each hash key/value'
) do |args|

  type = Puppet::Resource.new(nil, 'mcollective_setting')

  args.flatten.each do |settings|
    create_settings = settings.inject({}) do |hash, (key, value)|
      hash[key] = { :value => value }
      hash
    end
    function_create_resources(['mcollective_setting', create_settings])
  end

end
