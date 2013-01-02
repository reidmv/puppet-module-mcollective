require 'puppet/provider/parsedfile'
require 'ruby-debug'

Puppet::Type.type(:mcollective_setting).provide(
  :parsed,
  :parent         => Puppet::Provider::ParsedFile,
  :default_target => '', # real default is set in the type definition
  :filetype       => :flat
) do

  defaultfor :kernel => 'Linux'

  text_line :comment, :match => /^\s*#/
  text_line :blank, :match => /^\s*$/

  record_line(
    :parsed,
    :fields     => %w{name value comment},
    :optional   => %w{comment},
    :match      => /^\s*(\S+)\s*=\s*(\S+)\s*(?:#\s*(.*))?$/,
    :to_line    => proc { |hash|
      [:name, :value].each do |n|
        unless hash[n] and hash[n] != :absent
          raise ArgumentError, "#{n} is a required attribute"
        end
      end
      str = "#{hash[:name]} = #{hash[:value]}"
      unless [:absent, nil, ''].include?(hash[:comment])
        str += " # #{hash[:comment]}"
      end
      str
    }
  )

end
