require 'oauth'
require 'oauth/consumer'
require "evernote_oauth"

module Perican
  module Retriever
    class Evernote
      SANDBOX = true

      def initialize(consumer_key, consumer_secret, access_token)
        @consumer_key, @consumer_secret, @access_token =
          consumer_key, consumer_secret, access_token
      end

      def fetch
        client = ::EvernoteOAuth::Client.new(token: @access_token,
                                             consumer_key: @consumer_key,
                                             consumer_secret: @consumer_secret,
                                             sandbox: SANDBOX)
        note_store = client.note_store

        filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
        spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
        mds = note_store.findNotesMetadata(@access_token, filter, 0, 10, spec)

        collection = []
        mds.notes.each do |md|
          collection << note_store.getNote(@access_token,
                                     md.guid, true, false, false, false)
        end
        return collection
      end
    end # class Evernote
  end # module Retriever
end # module Perican
