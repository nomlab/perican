# Load libraries required by the Evernote OAuth
require 'oauth'
require 'oauth/consumer'

# Load Thrift & Evernote Ruby libraries
require "evernote_oauth"

# Client credentials
OAUTH_CONSUMER_KEY = "XXXXXXXXX"
OAUTH_CONSUMER_SECRET = "XXXXXXXXX"

# Connect to Sandbox server?
SANDBOX = true

ACCESS_TOKEN = "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"

client = EvernoteOAuth::Client.new(token:ACCESS_TOKEN, consumer_key:OAUTH_CONSUMER_KEY, consumer_secret:OAUTH_CONSUMER_SECRET, sandbox: SANDBOX)

user_store = client.user_store
note_store = client.note_store

filter = Evernote::EDAM::NoteStore::NoteFilter.new
result_spec = Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
metadatas = note_store.findNotesMetadata(ACCESS_TOKEN, filter, 0, 10, result_spec)

metadatas.notes.each do |notemetadata|
  note = note_store.getNote(ACCESS_TOKEN, notemetadata.guid, true, false, false, false)
  puts note.guid
  puts note.title
  puts note.content
  puts note.updated
end


