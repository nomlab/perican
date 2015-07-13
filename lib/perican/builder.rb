module Perican
  class Builder
    def initialize(config)
      @config = config
    end

    def resource_collection(type)
      case type
      when :mail
        conf = @config["MAIL"]
        resource = Perican::Resource::Mail
        retriever = Perican::Retriever::Mail.new(conf["LOGIN"],
                                                 conf["PASSWD"],
                                                 conf["SERVER"])
      when :evernote
        conf = @config["EVERNOTE"]
        resource = Perican::Resource::Evernote
        retriever = Perican::Retriever::Evernote.new(conf["CONSUMER_KEY"],
                                                     conf["CONSUMER_SECRET"],
                                                     conf["ACCESS_TOKEN"])
      when :slack
        conf = @config["SLACK"]
        resource = Perican::Resource::Slack
        retriever = Perican::Retriever::Slack.new(conf["TEAM"],
                                                  conf["TOKEN"],
                                                  conf["USERNAME"],
                                                  conf["CHANNEL"],
                                                  conf["COUNT"])
      when :toggl
        conf = @config["TOGGL"]
        resource = Perican::Resource::Toggl
        retriever = Perican::Retriever::Toggl.new(conf["TOKEN"])

      when :document
        conf = @config["DOCUMENT"]
        resource = Perican::Resource::Document
        retriever = Perican::Retriever::Document.new(conf["PATH"])
      end

      collection = Perican::ResourceCollection.new
      retriever.fetch.each do |item|
        collection << resource.new(item)
      end
      return collection
    end
  end # class Builder
end # module Perican
