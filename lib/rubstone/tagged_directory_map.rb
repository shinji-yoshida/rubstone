require 'fileutils'

module Rubstone
  class TaggedDirectoryMap
    include Helper

    attr_reader :tag_dir_map

    def initialize(hash)
      raise "hash is nil" if hash.nil?
      @tag_dir_map = {}
      hash.each do |key, value|
        @tag_dir_map[key] = TaggedDirectory.new(key, value)
      end
    end

    def tags
      @tag_dir_map.keys
    end

    def directory(tag)
      @tag_dir_map[tag].path
    end

    def tagged_directory(tag)
      @tag_dir_map[tag]
    end
  end

  class TaggedDirectory
    attr_reader :tag
    attr_reader :path
    attr_reader :exclusions

    def initialize(tag, value)
      @tag = tag
      if(value.kind_of?(String))
        @path = value
        @exclusions = []
      else
        @path = value["path"]
        @exclusions = value["exclusions"]
      end
    end
  end
end
