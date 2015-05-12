require 'active_support'
require 'active_support/core_ext'
require 'fileutils'

module Rubstone
  class Config
    attr_reader :cache_root
    attr_reader :lib_root
    attr_reader :dirctories
    attr_reader :tagged_directory_map

    def initialize(hash)
      hash.assert_valid_keys("cache_root", "lib_root", "directories")
      @cache_root = hash["cache_root"]
      @lib_root = hash["lib_root"]
      @dirctories = hash["directories"]
      raise "cache_root is not set" if @cache_root.blank?
      if @lib_root.blank? && @dirctories.blank?
        raise "lib_root or directories should be set"
      end
      if @dirctories.present?
        @tagged_directory_map = Rubstone::TaggedDirectoryMap.new(@directories)
      end
    end

    def mkdir_cache_root
      FileUtils.mkdir_p(cache_root)
    end

    def cache_path(name)
      File.join(cache_root, name)
    end

    def dest_lib_path(name)
      File.join(lib_root, name)
    end

    def repository_subdir(lib_name, tag)
      File.join(cache_root, lib_name, @tagged_directory_map.directories(tag))
    end

    def copied_subdir(lib_name, subdir)
      File.join(lib_root, lib_name, subdir)
    end
  end
end