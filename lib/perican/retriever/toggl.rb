require 'toggl_api'

module Perican
  module Retriever
    class Toggl
      def initialize(api_token)
        @api_token = api_token
      end

      def fetch
        client = ::Toggl::Base.new(@api_token)
        collection = []
        start_date = Time.new("2006-01-01") # from start of Toggl
        end_date = nil # to current time
        collection = client.get_time_entries(start_date, end_date)
        return collection
      end
    end # class Toggl
  end # module Retriever
end # module Perican
