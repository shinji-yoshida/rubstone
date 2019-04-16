require 'yaml'
require 'fileutils'
require 'optparse'
require 'rubstone/helper'
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
      command = ARGV.delete_at(0)

      rubfile = Rubstone::Rubfile.new(YAML.load_file("./Rubfile"))

      case command
      when "install"
        rubfile.libraries.each do |lib|
          puts "update #{lib.name}"
          lib.update_cache
          lib.copy_lib
        end
      when "update"
        target = ARGV.delete_at(0)
        puts "update #{target}"
        lib = rubfile.find_library(target)
        lib.update_cache
        lib.copy_lib
      when "dev_import"
        target = ARGV.delete_at(0)
        puts "import #{target}"
        lib = rubfile.find_library(target)
        lib.dev_import
      else
        puts "unknown command #{command}"
      end
    end
  end
end
