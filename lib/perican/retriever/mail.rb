require 'mail'
require 'net/imap'

module Perican
  module Retriever
    class Mail
      IMAP_SERVER = 'imap.gmail.com'

      def initialize(username, password, imap_server = IMAP_SERVER)
        @username, @password, @imap_server = username, password, imap_server
      end

      def fetch
        imap = Net::IMAP.new(@imap_server, 993, true)
        imap.login(@username, @password)
        imap.select('INBOX')

        ids = imap.search(["ALL"])
        collection = []

        imap.fetch(ids, "RFC822").each do |mail|
          collection << ::Mail.new(mail.attr["RFC822"])
        end
        return collection
      end

    end # class Mail
  end # module Perican
end # module Resource
