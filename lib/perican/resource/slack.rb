require 'uri'
require 'net/https'
require 'json'

module Perican
  module Resource
    class Slack

      def self.collection(auth_token, channel)
        params = {
          'token'   => auth_token,
          'channel' => channel,
          'count'   => 20
        }
        result = slackChatGetMessage(params)
        object = JSON.parse(result.body)

        cols = []
        object["messages"].each do |message|
          cols << self.new(message)
        end
        return cols
      end

      def initialize(channel, message)
        @message = message
      end

      def uid
        @message.guid
      end

      def date
        @message["latest"]
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

      def metadata
        opts = {
          :description => description,
          :originator  => originator,
          :recipients  => recipients
        }
        Perican::Metadata.new(self, uid, date, summary, opts)
      end

      private

      def slackChatGetMessage(params)
        return slackApi('channels.history', params)
      end

      def slackApi(method, params)
        url = 'https://slack.com/api/' + method
        headers = {}
        return getRequest(url, params, headers)
      end

      def getRequest(url, params, headers = {})
        uri = URI.parse(url)
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(uri.path)
        request.set_form_data(params)
        res = https.request(request)
        return res
      end


    end # class Slack
  end # module Resource
end # module Perican
