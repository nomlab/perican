require "perican/version"

module Perican
  dir = File.dirname(__FILE__) + "/perican"

  autoload :Resource,             "#{dir}/resource.rb"
  autoload :Metadata,             "#{dir}/metadata.rb"
  autoload :Version,              "#{dir}/version.rb"
end
