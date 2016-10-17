require 'uri'
require 'net/https'
require 'json'

module Perican
  module Sender
    class Camome < Base
      def initialize(url)
        @url = url
        @headers = {"Content-Type" => "application/json"}
      end

      def url
        @url
      end

      def headers
        @headers
      end
    end
  end
end
