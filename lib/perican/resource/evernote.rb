require 'oauth'
require 'oauth/consumer'
require "evernote_oauth"

module Perican
  module Resource
    class Evernote < Base
      TYPE = "evernote"

      def initialize(note)
        @note = note
      end

      def uid
        @note.guid
      end

      def date
        @note.updated
      end

      def summary
        @note.title
      end

      def description
        @note.content
      end

      def originator
        nil
      end

      def recipients
        []
      end

    end # class Evernote
  end # module Resource
end # module Perican
