require 'puppet/provider/parsedfile'
require 'ruby-debug'

Puppet::Type.type(:mcollective_setting).provide(
  :parsed,
  :parent         => Puppet::Provider::ParsedFile,
  :default_target => File.join(Facter.value('mcollective_confdir'), 'server.cfg'),
  :filetype       => :flat
) do

  defaultfor :kernel => 'Linux'

  text_line :comment, :match => /^\s*#/
  text_line :blank, :match => /^\s*$/

  record_line(
    :parsed,
    :fields     => %w{name value},
    :optional   => %w{comment},
    :match      => /^\s*(\S+)\s*=\s*(\S+)\s*(:?#(.*))?$/,
    :post_parse => proc { |hash|
      hash[:comment] = '' unless hash[:comment]
    },
    :to_line    => proc { |hash|
      [:name, :value].each do |n|
        unless hash[n] and hash[n] != :absent
          raise ArgumentError, "#{n} is a required attribute"
        end
      end
      str = "#{hash[:name]} = #{hash[:value]}"
      if hash.include? :comment and !hash[:comment].empty?
        str += " ##{hash[:comment]}"
      end
      str
    }
  )

end
