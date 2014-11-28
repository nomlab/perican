require 'uri'
require 'net/https'
require 'json'

module Perican
  module Retriever
    class Slack

      def initialize(team, token, username, channel, count = 20)
        @params = {
          'token'   => token,
          'channel' => channel,
          'count'   => count
        }
      end

      def fetch
        json = channels_history

        collection = []
        json["messages"].each do |message|
          collection << message
        end
        return collection
      end

      private

      def channels_history
        channel = channel_name_to_id(@params["channel"])
        p = {:token => @params["token"], :channel => channel}
        return slackApi('channels.history', p)
      end

      def channel_name_to_id(channel_name)
        p = {"token" => @params["token"]}
        slackApi('channels.list', p)["channels"].each do |c|
          if c["name"] == channel_name.sub(/^#/, "")
            return c["id"]
          end
        end
        return nil
      end

      def slackApi(method, params)
        url = 'https://slack.com/api/' + method
        return JSON.parse(getRequest(url, params).body)
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
  end # module Retriever
end # module Perican
