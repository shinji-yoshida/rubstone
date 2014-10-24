require 'active_support'
require 'active_support/core_ext'

module Rubstone
  class Rubfile
    attr_reader :config
    attr_reader :libraries

    def initialize(hash)
      hash.assert_valid_keys("config", "libs")
      config_hash = hash["config"]
      libs = hash["libs"]
      raise "config is not set" if config_hash.blank?

      @config = Rubstone::Config.new(config_hash)
      @libraries = libs.map{|lib| Rubstone::Library.new(lib, @config)}
    end

    def find_library(name)
      @libraries.find{|lib| lib.name == name}
    end
  end
end