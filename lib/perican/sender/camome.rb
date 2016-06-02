require 'uri'
require 'net/https'
require 'json'

module Perican
  module Sender
    class Camome
      def initialize
        # URL is unkown
        URL = 'https://...'
        @headers = {"Content-Type" => "application/json"}
      end

      # Post resource to camome with json format
      def post_resource(resource)
        json = resource_to_json(resource)
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

      def resource_to_json(resource)
        JSON.generate({:clam => resource.metadate.to_hash,
                       :resource => resource.to_hash})
      end
    end
  end
end
