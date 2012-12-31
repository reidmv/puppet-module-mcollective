require 'puppetx/filemapper'

Puppet::Type.type(:mcollective_setting).provide(:mapped) do
  include PuppetX::FileMapper

  #defaultfor :kernel => 'Linux'

  desc "Generic filemapper provider"

  def select_file
    File.join(Facter['mcollective_confdir'].value, 'server.cfg')
  end

  def self.target_files
    [File.join(Facter['mcollective_confdir'].value, 'server.cfg')]
  end

  def self.parse_file(filename, contents)
    lines = contents.split("\n")
    lines.map! { |line| line.sub(/#.*$/, '') }
    lines.reject! { |line| line.match(/^\s*$/) }

    pair_regex = %r/^\s*(\S+)\s*=\s*(\S+)\s*$/

    pairs = lines.map do |line|
      m = line.match pair_regex
      raise(Puppet::Error, <<-EOL.gsub(/\s+/, " ").strip) unless m
        #{filename} is malformed; "#{line}" did not match "#{pair_regex.to_s}"
      EOL
      { :name => m[1], :key => m[1], :value => m[2] }
    end

    pairs
  end

  def self.format_file(filename, providers)
    content = providers.inject([]) do |arr, provider|
      provider.key ||= '# EMPTY KEY #'
      arr << "#{provider.key} = #{provider.value}"
    end

    content.sort.join("\n")
  end

end
