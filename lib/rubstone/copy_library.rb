require 'fileutils'

module Rubstone
  class CopyLibrary
    def initialize(library)
      @library = library
      @config = @library.config
    end

    def copy_lib(excludes=[])
      @library.directory_relations.each do |rel|
        copy_dir(rel.repository_dir, rel.copied_dir, excludes + rel.exclusions)
      end
    end

    def reverse_copy_lib(excludes=[])
      @library.directory_relations.each do |rel|
        copy_dir(rel.copied_dir, rel.repository_dir, excludes + rel.exclusions)
      end
    end

    def copy_dir(src_path, dst_path, excludes=[])
      FileUtils.mkdir_p(File.dirname(src_path))
      FileUtils.mkdir_p(File.dirname(dst_path))
      local_excludes = excludes + [".git"]
      exclude_phrase = local_excludes.map{|e| "--exclude=\"#{e}\""}.join(" ")
      src_path = src_path.end_with?("/") ? src_path : "#{src_path}/"
      puts "rsync -a #{exclude_phrase} --delete \"#{src_path}\" \"#{dst_path}\""
      system("rsync -a #{exclude_phrase} --delete \"#{src_path}\" \"#{dst_path}\"")
    end
  end
end