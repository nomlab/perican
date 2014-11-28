module Perican
  module Resource
    class Base
      def metadata
        opts = {
          :description => description,
          :originator  => originator,
          :recipients  => recipients
        }
        Perican::Metadata.new(self, uid, date, summary, opts)
      end
    end

    dir = File.dirname(__FILE__) + "/resource"

    autoload :Mail,             "#{dir}/mail.rb"
    autoload :Evernote,         "#{dir}/evernote.rb"
    autoload :Slack,            "#{dir}/slack.rb"
  end
end
