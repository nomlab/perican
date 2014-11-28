require 'oauth'
require 'oauth/consumer'
require "evernote_oauth"

module Perican
  module Resource
    class Evernote
      SANDBOX = true

      def self.collection(oauth_consumer_key,
                          oauth_consumer_secret,
                          access_token)
        client = ::EvernoteOAuth::Client.new(token:access_token,
                                             consumer_key: oauth_consumer_key,
                                             consumer_secret: oauth_consumer_secret,
                                             sandbox: SANDBOX)
        note_store = client.note_store

        filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
        result_spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
        metadatas = note_store.findNotesMetadata(access_token,
                                                 filter,
                                                 0,
                                                 10,
                                                 result_spec)
        cols = []
        metadatas.notes.each do |notemetadata|
          note = note_store.getNote(access_token,
                                    notemetadata.guid, true, false, false, false)
          cols << self.new(note)
        end
        return cols
      end

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

      def metadata
        opts = {
          :description => description,
          :originator  => originator,
          :recipients  => recipients
        }
        Perican::Metadata.new(self, uid, date, summary, opts)
      end
    end # class Evernote
  end # module Resource
end # module Perican
