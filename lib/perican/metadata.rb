#
# Wrapper class for RSS::Maker atom
# http://www.ruby-doc.org/stdlib-2.1.2/libdoc/rss/rdoc/RSS/Atom.html
#
module Perican
  class Metadata
    OPTION_KEYWORDS = [:description, :originator, :recipients]

    attr_reader :uid, :date, :summary, :options

    def initialize(content, uid, date, summary, **options)
      @options = {}
      @content, @uid, @date, @summary = content, uid, date, summary
    end
  end

  class MetadataCollection
    def initialize
      @collection = []
    end

    def <<(o)
      @collection << o
    end

    def to_atom
      atom = RSS::Maker.make("atom") do |maker|
        maker.channel.author = "CAMOME"
        maker.channel.updated = Time.now.to_s
        maker.channel.about = "http://github.com/nomlab/camome"
        maker.channel.title = "CAMOME Feed"

        @collection.each do |article|
          maker.items.new_item do |atom_item|
            atom_item.link = article.link
            atom_item.title = article.title
            atom_item.updated = Time.now.to_s
          end
        end
      end
      return atom
    end
  end
end
