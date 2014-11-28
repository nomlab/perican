module Perican
  module Resource
    dir = File.dirname(__FILE__) + "/resource"

    autoload :Mail,             "#{dir}/mail.rb"
    autoload :Evernote,         "#{dir}/evernote.rb"
  end
end
