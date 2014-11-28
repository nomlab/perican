require 'mail'
require 'net/imap'

module Perican
  module Resource
    class Mail
      IMAP_SERVER = 'imap.gmail.com'

      def self.collection(username, password, imap_server = IMAP_SERVER)
        imap = Net::IMAP.new(imap_server, 993, true)
        imap.login(username, password)
        imap.select('INBOX')

        ids = imap.search(["ALL"])
        cols = []

        imap.fetch(ids, "RFC822").each do |mail|
          cols << self.new(::Mail.new(mail.attr["RFC822"]))
        end
        return cols
      end

      def initialize(mail)
        @mail = mail
      end

      def uid
        @mail.message_id
      end

      def date
        @mail.date
      end

      def summary
        @mail.subject
      end

      def description
        @mail.body
      end

      def originator
        @mail.from
      end

      def recipients
        (@mail.to || []) + (@mail.cc || [])
      end

      def metadata
        opts = {
          :description => description,
          :originator  => originator,
          :recipients  => recipients
        }
        Perican::Metadata.new(self, uid, date, summary, opts)
      end
    end # class Mail
  end # module Perican
end # module Resource
