module Perican
  module Retriever
    dir = File.dirname(__FILE__) + "/retriever"

    autoload :Mail,             "#{dir}/mail.rb"
    autoload :Evernote,         "#{dir}/evernote.rb"
    autoload :Slack,            "#{dir}/slack.rb"
    autoload :Toggl,            "#{dir}/toggl.rb"
    autoload :Document,         "#{dir}/document.rb"
  end
end
