module Perican
  module Resource
    class Document < Base
      def initialize(document)
        @document = document
      end

      def uid
        @document[:inode]
      end

      def date
        @document[:atime]
      end

      def summary
        @document[:path]
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

      def source
        @document
      end
    end # class Document
  end # module Resource
end # module Perican
