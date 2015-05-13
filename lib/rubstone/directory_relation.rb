require 'fileutils'

module Rubstone
  class DirectoryRelation
    attr_reader :repository_dir
    attr_reader :copied_dir

    def initialize(repository_dir, copied_dir)
      @repository_dir = repository_dir
      @copied_dir = copied_dir
    end
  end
end