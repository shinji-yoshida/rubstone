module Rubstone
  class CopyLibrary
    def initialize(library)
      @library = library
      @config = @library.config
    end

    def copy_lib
      directory_relation = @library.directory_relations.first
      copy_dir(directory_relation.repository_dir, directory_relation.copied_dir)
    end

    def copy_dir(src_path, dst_path)
      FileUtils.mkdir_p dst_path
      src_path = src_path.end_with?("/") ? src_path : "#{src_path}/"
      system("cp -R #{src_path} #{dst_path}")
      system("rm -rf #{dst_path}/.git")
    end
  end
end