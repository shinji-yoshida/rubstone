require 'active_support'
require 'active_support/core_ext'
require 'fileutils'

module Rubstone
  class Config
    attr_reader :cache_root
    attr_reader :lib_root

    def initialize(hash)
      hash.assert_valid_keys("cache_root", "lib_root")
      @cache_root = hash["cache_root"]
      @lib_root = hash["lib_root"]
      raise "cache_root is not set" if @cache_root.blank?
      raise "lib_root is not set" if @lib_root.blank?
    end

    def mkdir_cache_root
      FileUtils.mkdir_p(cache_root)
    end
  end
end