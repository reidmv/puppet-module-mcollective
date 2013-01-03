Puppet::Parser::Functions.newfunction(
  :zipjoin,
  :type => :rvalue,
  :doc  => 'Zip two arrays together and join the results'
) do |args|

  raise(Puppet::Error, <<-EOL.gsub(/\s+/, " ").strip) unless args.count == 3
    zipjoin(): Wrong number of arguments given (#{args.size} for 3
  EOL

  unless args[0].is_a?(Array) and args[1].is_a?(Array)
    raise Puppet::ParseError, 'zipjoin(): first two arguments must be arrays'
  end

  unless args[2].is_a?(String)
    raise Puppet::ParseError, 'zipjoin(): third argument must be a string'
  end

  function_zip([args[0], args[1]]).map { |e| e.join(args[2]) }

end
