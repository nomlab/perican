require 'mail'
require 'net/imap'

module Perican
  module Resource
    class Mail < Base
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

      def source
        @mail
      end

    end # class Mail
  end # module Resource
end # module Perican
