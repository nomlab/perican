# -*- coding: utf-8 -*-
require 'json'

module Perican
  module Retriever
    class Document
      def initialize(path, ignore, ignore_hidden)
        @params = {
          'path'   => path,
          'ignore' => ignore,
          'ignore_hidden' => ignore_hidden
        }
      end

      def fetch
        collection = []

        path = File.expand_path(@params["path"])

        if @params["ignore"] == nil
          command = "find #{path} -atime -1 -exec stat -f '%i, %Sa, %N' -t '%F %T' {} \+"
        else
          ignore_str = "\\("
          ignore = @params["ignore"].split(",")
          ignore.each do |i|
            i = i.lstrip
            i = i.rstrip
            ignore_str << " -name #{i}"
          end
          ignore_str << " \\)"
          command = "find #{path} #{ignore_str} -prune -o -exec stat -f '%i, %Sa, %N' -t '%F %T' {} \+"
        end

        command << " | grep -v '\\/\\.'" if @params["ignore_hidden"] == true

        documents = `#{command}`
        documents.split("\n").each do |doc|
          d = doc.split(",")
          collection << {"uid" => d[0], "date" => d[1].lstrip, "summary" => "file://#{d[2].lstrip}"}
        end
        return collection
      end
    end
  end
end
