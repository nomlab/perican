require 'uri'
require 'net/https'
require 'json'

module Perican
  module Sender
    class Camome
      def initialize
        # URL is unkown
        @url = 'http://...'
        @headers = {"Content-Type" => "application/json"}
      end

      # Post resource to camome with json format
      def post_resource(resource)
        json = resource_to_json(resource)
        return post_request(@url, json, @headers)
      end

      private

      def post_request(url, param, headers = {})
        uri = URI.parse(url)
        ## But now we are using http to fit the Camome,
        ## In the future we plan to use the https.
        http = Net::HTTP.new(uri.host, uri.port)

        request = Net::HTTP::Post.new(uri.path)
        request["Content-Type"] = headers["Content-Type"]
        request.body = param
        res = http.request(request)
        return res
      end

      def resource_to_json(resource)
        JSON.generate({:clam => resource.metadata.to_hash,
                       :resource => resource.to_hash})
      end
    end
  end
end
