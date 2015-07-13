module Perican
  module Resource
    class Document < Base
      def initialize(document)
        @document = document
      end

      def uid
        @document["uid"]
      end

      def date
        @document["date"]
      end

      def summary
        @document["summary"]
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
    end # class Document
  end # module Resource
end # module Perican
