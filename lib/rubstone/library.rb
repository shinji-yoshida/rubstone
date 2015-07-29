require 'active_support'
require 'active_support/core_ext'

module Rubstone
  class Library
    attr_reader :name
    attr_reader :repository
    attr_reader :include_metafile
    attr_reader :ref
    attr_reader :config

    def initialize(hash, config)
      hash.assert_valid_keys("name", "repository", "include_metafile", "ref", "lib_root", "directories")
      @name = hash["name"]
      @repository = hash["repository"]
      @include_metafile = hash["include_metafile"]
      @ref = hash["ref"]
      @lib_root = hash["lib_root"]
      @directories = hash["directories"]
      raise "name is not set" if @name.blank?
      raise "repository is not set" if @repository.blank?
      raise "ref is not set" if @ref.blank?
      if @lib_root.blank? && @directories.blank?
        raise "lib_root or directories should be set"
      end

      @config = config
      if @directories.present?
        @tagged_directory_map = Rubstone::TaggedDirectoryMap.new(@directories)
      end
    end

    def update_cache
      if File.exist? cache_path
        git_action.pull
        git_action.checkout_ref(ref)
      else
        git_action.git_clone(repository)
        git_action.checkout_ref(ref)
      end
    end

    private

    def git_action
      Rubstone::GitAction.new(cache_path)
    end

    def cache_path
      @config.cache_path(name)
    end

    public

    def directory_relations
      if @tagged_directory_map.nil?
        return [Rubstone::DirectoryRelation.new(cache_lib_path, dest_lib_path)]
      end

      @tagged_directory_map.tags.map { |tag|
        tagged_dir = @tagged_directory_map.tagged_directory(tag)
        Rubstone::DirectoryRelation.new(
          @config.repository_subdir(name, tagged_dir.path),
          @config.copied_subdir(name, tag),
          tagged_dir.exclusions
          )
      }
    end

    def copy_lib
      excludes = include_metafile ? [] : ["*.meta"]

      Rubstone::CopyLibrary.new(self).copy_lib(excludes)
    end

    def cache_lib_path
      File.join(cache_path, lib_root)
    end

    def dest_lib_path
      @config.dest_lib_path(name)
    end

    private

    def lib_root
      @lib_root
    end

    public

    def dev_import
      excludes = include_metafile ? [] : ["*.meta"]

      Rubstone::CopyLibrary.new(self).reverse_copy_lib(excludes)
    end
  end
end

