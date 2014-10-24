require 'active_support'
require 'active_support/core_ext'

module Rubstone
  class Library
    attr_reader :name
    attr_reader :repository
    attr_reader :ref

    def initialize(hash, config)
      hash.assert_valid_keys("name", "repository", "ref", "lib_root")
      @name = hash["name"]
      @repository = hash["repository"]
      @ref = hash["ref"]
      @lib_root = hash["lib_root"]
      raise "name is not set" if @name.blank?
      raise "repository is not set" if @repository.blank?
      raise "ref is not set" if @ref.blank?
      raise "lib_root is not set" if @lib_root.blank?

      @config = config
    end

    def update_cache
      if File.exist? cache_path
        pull
        checkout_ref
      else
        git_clone
        checkout_ref
      end
    end

    private

    def cache_path
      File.join(@config.cache_root, name)
    end

    def git_clone
      system("git clone #{repository} #{cache_path}")
    end

    def checkout_ref
      system("cd #{cache_path} ; git checkout #{ref}")
    end

    def pull
      system("cd #{cache_path} ; git pull")
    end

    public

    def copy_lib
      FileUtils.mkdir_p dest_lib_path
      cache_lib_directory = cache_lib_path.end_with?("/") ? cache_lib_path : "#{cache_lib_path}/"
      system("cp -R #{cache_lib_directory} #{dest_lib_path}")
      system("rm -rf #{dest_lib_path}/.git")
    end

    def delete_removed_files
      dest_files = Dir.glob(File.join(dest_lib_path, "**/*")).reject{ |fn|
        File.extname(fn) == ".meta"
      }
      delete_files = dest_files.reject{ |fn|
        relative_path = fn.sub(dest_lib_path, '')
        File.exist? File.join(cache_lib_path, relative_path)
      }

      delete_files.each do |f|
        system("rm -rf #{f}")
        system("rm -rf #{f}.meta")
      end
    end

    private

    def cache_lib_path
      File.join(cache_path, lib_root)
    end

    def lib_root
      @lib_root
    end

    def dest_lib_path
      File.join(@config.lib_root, name)
    end

    public

    def dev_import
      dest_lib_directory = dest_lib_path.end_with?("/") ? dest_lib_path : "#{dest_lib_path}/"
      system("rm -rf #{cache_lib_path}")
      system("cp -R #{dest_lib_directory} #{cache_lib_path}")
      meta_files = Dir.glob(File.join(cache_lib_path, "**/*")).select{|f|
        File.extname(f) == ".meta"
      }
      meta_files.each do |f|
        system("rm #{f}")
      end
    end
  end
end

