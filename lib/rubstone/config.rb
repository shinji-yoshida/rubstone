require 'fileutils'

module Rubstone
  class Config
    include Helper

    attr_reader :cache_root
    attr_reader :lib_root
    attr_reader :directories
    attr_reader :tagged_directory_map

    def initialize(hash)
      @cache_root = hash["cache_root"]
      @lib_root = hash["lib_root"]
      @directories = hash["directories"]
      raise "cache_root is not set" if hash_blank?(@cache_root)
      if hash_blank?(@lib_root) && hash_blank?(@directories)
        raise "lib_root or directories should be set"
      end
      if hash_present?(@directories)
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

    def repository_subdir(lib_name, subdir)
      File.join(cache_root, lib_name, subdir)
    end

    def copied_subdir(lib_name, tag)
      File.join(@tagged_directory_map.directory(tag), lib_name)
    end
  end
end
