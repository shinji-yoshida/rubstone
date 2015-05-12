require 'active_support'
require 'active_support/core_ext'
require 'fileutils'

module Rubstone
  class TaggedDiretoryMap
    attr_reader :tag_dir_map

    def initialize(hash)
      @tag_dir_map = hash
    end
  end
end