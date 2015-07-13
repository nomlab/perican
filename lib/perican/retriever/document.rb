# -*- coding: utf-8 -*-
require 'json'

module Perican
  module Retriever
    class Document
      def initialize(path)
        @params = {
          'path'   => path
        }
      end

      def fetch
        collection = []

        documents = File.open(File.expand_path(@params["path"])).read
        documents.split("\n").each do |doc|
          d = doc.split(",")
          collection << {"uid" => d[0], "date" => d[1], "summary" => d[2]}
        end
        return collection
      end
    end
  end
end
