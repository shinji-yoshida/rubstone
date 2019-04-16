
module Rubstone
  class Rubfile
    include Helper

    attr_reader :config
    attr_reader :libraries

    def initialize(hash)
      config_hash = hash["config"]
      libs = hash["libs"]
      raise "config is not set" if hash_blank?(config_hash)

      @config = Rubstone::Config.new(config_hash)
      @libraries = libs.map{|lib| Rubstone::Library.new(lib, @config)}
    end

    def find_library(name)
      @libraries.find{|lib| lib.name == name}
    end
  end
end
