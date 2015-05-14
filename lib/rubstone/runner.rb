require 'yaml'
require 'fileutils'
require 'optparse'
require 'rubstone/config'
require 'rubstone/library'
require 'rubstone/rubfile'
require 'rubstone/git_action'
require 'rubstone/copy_library'
require 'rubstone/tagged_directory_map'
require 'rubstone/directory_relation'

module Rubstone
  class Runner
    def run
      command = ARGV[0]

      rubfile = Rubstone::Rubfile.new(YAML.load_file("./Rubfile"))

      case command
      when "install"
        rubfile.libraries.each do |lib|
          puts "update #{lib.name}"
          lib.update_cache
          lib.delete_removed_files
          lib.copy_lib
        end
      when "dev_import"
        opts = ARGV.getopts("m")
        target = ARGV[1]
        lib = rubfile.find_library(target)
        lib.dev_import(opts)
      else
        puts "unknown command #{command}"
      end
    end
  end
end