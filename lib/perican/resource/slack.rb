require 'uri'
require 'net/https'
require 'json'

module Perican
  module Resource
    class Slack < Base
      def initialize(message)
        @message = message
      end

      def uid
        #@message.guid
      end

      def date
        # @message["latest"]
      end

      def summary
        @message["text"]
      end

      def description
        nil
      end

      def originator
        nil
      end

      def recipients
        []
      end

    end # class Slack
  end # module Resource
end # module Perican
