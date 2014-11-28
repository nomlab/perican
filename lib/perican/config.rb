require "yaml"

module Perican
  class Config
    def initialize(config_file)
      @config_string = File.open(File.expand_path(config_file)).read
      @config_hash = YAML.load(@config_string, config_file) || {}
    end

    def [](key)
      return @config_hash[key]
    end

  end # class Config
end # module Perican
