require 'yaml'
require 'fileutils'
require 'rubstone/config'
require 'rubstone/library'
require 'rubstone/rubfile'
require 'rubstone/git_action'
require 'rubstone/copy_library'
require 'rubstone/tagged_directory_map'
require 'rubstone/directory_relation'

module Rubstone
  class Runner
    def initialize(argv)
      @argv = argv
      command = argv[0]
    end

    def run
      rubfile = Rubstone::Rubfile.new(YAML.load_file("./Rubfile"))
      command = @argv[0]

      case command
      when "install"
        rubfile.libraries.each do |lib|
          puts "update #{lib.name}"
          lib.update_cache
          lib.delete_removed_files
          lib.copy_lib
        end
      when "dev_import"
        target = @argv[1]
        lib = rubfile.find_library(target)
        lib.dev_import
      else
        puts "unknown command #{command}"
      end
    end
  end
end