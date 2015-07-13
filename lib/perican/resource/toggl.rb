require 'toggl_api'

module Perican
  module Resource
    class Toggl < Base
      TYPE = "toggl"

      def initialize(time_entry)
        @time_entry = time_entry
      end

      def uid
        @time_entry.uid
      end

      def date
        Time.parse @time_entry.stop
      end

      def summary
        @time_entry.description
      end

      def description
        @time_entry.description
      end

      def originator
        nil
      end

      def recipients
        nil
      end
    end # class Toggl
  end # module Resource
end # module Perican
