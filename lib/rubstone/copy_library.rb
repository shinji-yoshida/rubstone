module Rubstone
  class CopyLibrary
    def initialize(library)
      @library = library
      @config = @library.config
    end

    def copy_lib
      @library.directory_relations.each do |rel|
        copy_dir(rel.repository_dir, rel.copied_dir)
      end
    end

    def copy_dir(src_path, dst_path)
      FileUtils.mkdir_p dst_path
      src_path = src_path.end_with?("/") ? src_path : "#{src_path}/"
      puts "cp -R #{src_path} #{dst_path}"
      system("cp -R #{src_path} #{dst_path}")
      system("rm -rf #{dst_path}/.git")
    end
  end
end