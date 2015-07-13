require 'uri'
require 'net/https'

module Perican
  module Sender
    class Camome
      def initialize
        # URL is unkown ...
        URL = 'https://...'
        @headers = {"Content-Type" => "application/json"}
      end

      def post_resource(json)
        return post_request(URL, json, @headers)
      end

      private

      def post_request(url, param, headers = {})
        uri = URI.parse(url)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(uri.path)
        request["Content-Type"] = headers["Content-Type"]
        request.body = param
        res = https.request(request)
        return res
      end
    end
  end
end
