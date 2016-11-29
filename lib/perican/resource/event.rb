require 'uri'
require 'net/https'
require 'json'
require 'date'
require 'base64'
require 'google/apis/calendar_v3'

module Perican
  module Resource
    class Event < Base
      def initialize(event)
        @event = event
      end

      def uid
        @event.id
      end

      def date
        @event.start.date || @event.start.date_time
      end

      def summary
        @event.summary
      end

      def description
        @event.description || ""
      end

      def originator
        nil
      end

      def recipients
        []
      end

      def source
        @event
      end

      def to_hash
        {:type => self.class,
         :source => Base64.encode64(Marshal.dump(self.source))}
      end
    end # class Event
  end # module Resource
end # module Perican
