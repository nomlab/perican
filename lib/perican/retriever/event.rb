require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'google/api_client/client_secrets'
require 'google/apis/calendar_v3'
require 'json'
require 'date'

module Perican
  module Retriever
    class Event

      def initialize(user_id, calendar_id, client_id, client_secret)
        @user_id = user_id
        @calendar_id = calendar_id
        @client_id = client_id
        @client_secret = client_secret
        @application_name = "perican"
        @time_zone = 'Japan'
        @oob_url = 'urn:ietf:wg:oauth:2.0:oob'
      end

      def fetch
        collection = []  
        border = DateTime.parse(set_updateMin)
        response = get_events(border)
        
        last = border
        
        response.items.each do |item|
          next if item.status == "cancelled"
          created = item.created
          collection << item if created > border
          last = created if created > last
        end
        update_updateMin(last.to_s)
        return collection
      end

      private

      def set_updateMin
        begin
          return File.read(File.expand_path("~/.config/perican/update_min.txt", __FILE__))
        rescue
          return "2000-01-01T00:00:00"
        end
      end
      
      def update_updateMin(str)
        begin
          File.write(File.expand_path("~/.config/perican/update_min.txt", __FILE__), str)
          return true
        rescue
          return false
        end
      end
      
      def get_events(time) 
        params = {:order_by => "updated", :show_deleted => "false", :updated_min => time.strftime("%Y-%m-%dT%H:%M:%SZ")}
        return google_calendar_api(params)
      end

      def authorize
        dir_path = "~/.config/perican"
        client_id = Google::Auth::ClientId.new(@client_id, @client_secret)
        token_store = Google::Auth::Stores::FileTokenStore.new(
          file: File.expand_path("#{dir_path}/google_access_tokens.yml", __FILE__))
        scope = 'https://www.googleapis.com/auth/calendar'
        authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)
        
        credentials = authorizer.get_credentials(@user_id)
        if credentials.nil?
          url = authorizer.get_authorization_url(
            base_url: @oob_url)
          puts "Open the following URL in the browser and enter the " +
               "resulting code after authorization"
          puts url
          code = STDIN.gets.chomp
          credentials = authorizer.get_and_store_credentials_from_code(
            user_id: @user_id, code: code, base_url: @oob_url)
        end
        return credentials
      end
      
      def google_calendar_api(params)
        service = Google::Apis::CalendarV3::CalendarService.new
        service.client_options.application_name = @application_name
        service.authorization = authorize()
        service.authorization.refresh!

        response = service.list_events(@calendar_id, order_by: params[:order_by], show_deleted: params[:show_deleted], updated_min: params[:updated_min])

        return response
      end
      
    end # class Event
  end # module Retriever
end # module Perican

