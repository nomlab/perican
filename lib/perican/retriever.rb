module Perican
  module Retriever
    dir = File.dirname(__FILE__) + "/retriever"

    autoload :Mail,             "#{dir}/mail.rb"
    autoload :Evernote,         "#{dir}/evernote.rb"
    autoload :Slack,            "#{dir}/slack.rb"
  end
end
