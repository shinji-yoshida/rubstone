require 'active_support'
require 'active_support/core_ext'
require 'fileutils'

module Rubstone
  class TaggedDiretoryMap
    attr_reader :tag_dir_map

    def initialize(hash)
      @tag_dir_map = hash
    end

    def tags
      @tag_dir_map.keys
    end

    def directory(tag)
      @tag_dir_map[tag]
    end
  end
end