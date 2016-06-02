# -*- coding: utf-8 -*-
require 'json'

module Perican
  module Retriever
    class Document
      def initialize(path, ignore, ignore_hidden)
        @params = {
          'path'   => path,
          'ignore' => ignore
        }
      end

      def fetch
        path = File.expand_path(@params["path"])

        if @params["ignore"] == nil
          documents = `find #{path} -atime -1 -type f -print0 | xargs -n 100 -0 stat -f '{device_number: "%d", inode: "%i", permissions: "%p", hardlinks: "%l", user: "%u", group: "%g", special_file_device_number: "%r", size: "%z", atime: "%Sa", mtime: "%Sm", ctime: "%Sc", type: "%HT", optimal_block_size: "%k", blocks: "%b", file_flags: "%f", path: "%N"}' -t '%F %T'`
        else
          ignore_str = "\\( "
          ignore = @params["ignore"].split(",")
          ignore.map!{|i|
            i = i.lstrip
            i = i.rstrip
            i = "-name '#{i}'"
          }
          ignore_str << ignore.join(" -o ")
          ignore_str << " \\)"
          documents = `find #{path} #{ignore_str} -prune -o -atime -1 -type f -print0 | xargs -n 100 -0 stat -f '{device_number: "%d", inode: "%i", permissions: "%p", hardlinks: "%l", user: "%u", group: "%g", special_file_device_number: "%r", size: "%z", atime: "%Sa", mtime: "%Sm", ctime: "%Sc", type: "%HT", optimal_block_size: "%k", blocks: "%b", file_flags: "%f", path: "%N"}' -t '%F %T'`
        end

        collection = documents.split("\n").map{|doc| doc = eval(doc)}
      end
    end
  end
end
