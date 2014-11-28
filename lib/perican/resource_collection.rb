module Perican
  class ResourceCollection
    include Enumerable

    def initialize
      @collection = []
    end

    def <<(o)
      @collection << o
    end

    def each
      @collection.each do |resource|
        yield resource
      end
    end
  end # module ResourceCollection
end # module Perican
