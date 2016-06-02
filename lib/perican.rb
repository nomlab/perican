require "perican/version"

module Perican
  dir = File.dirname(__FILE__) + "/perican"

  autoload :Builder,              "#{dir}/builder.rb"
  autoload :Config,               "#{dir}/config.rb"
  autoload :Metadata,             "#{dir}/metadata.rb"
  autoload :Resource,             "#{dir}/resource.rb"
  autoload :ResourceCollection,   "#{dir}/resource_collection.rb"
  autoload :Retriever,            "#{dir}/retriever.rb"
  autoload :Version,              "#{dir}/version.rb"
  autoload :Sender,               "#{dir}/sender.rb"
end
