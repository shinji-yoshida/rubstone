require 'fileutils'

module Rubstone
  module Helper
    def hash_blank?(hash)
      hash.nil? || hash.empty?
    end

    def string_blank?(str)
      str.nil? || str.empty?
    end

    def hash_present?(hash)
      ! hash_blank?(hash)
    end
  end
end
