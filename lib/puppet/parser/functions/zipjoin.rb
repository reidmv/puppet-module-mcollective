Puppet::Parser::Functions.newfunction(
  :zipjoin,
  :type => :rvalue,
  :doc  => 'Zip two arrays together and join the results'
) do |args|

  raise(Puppet::Error, <<-EOL.gsub(/\s+/, " ").strip) unless args.count >= 3
    zipjoin(): Wrong number of arguments given (#{args.size} for minimum of 3)
  EOL

  unless args[0].is_a?(String)
    raise Puppet::ParseError, 'zipjoin(): first argument must be a string'
  end

  unless args[1..-1].is_a?(Array)
    raise Puppet::ParseError, 'zipjoin(): argument 1 and above must be arrays'
  end

  delim = args[0]
  args.shift(1)
  result = function_zip([args[0], args[1]]).map{ |e| e.join(delim) }
  args.shift(2)

  until args.empty? do
    result = function_zip([result, args[0]]).map{ |e| e.join(delim) }
    args.shift
  end

  result
end
