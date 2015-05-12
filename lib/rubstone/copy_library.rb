module Rubstone
  class CopyLibrary
    def initialize(library)
      @library = library
    end

    def copy_lib
      legacy_copy_lib
    end

    def legacy_copy_lib
      copy_dir(@library.cache_lib_path, @library.dest_lib_path)
    end

    def copy_dir(src_path, dst_path)
      FileUtils.mkdir_p dst_path
      src_path = src_path.end_with?("/") ? src_path : "#{src_path}/"
      system("cp -R #{src_path} #{dst_path}")
      system("rm -rf #{dst_path}/.git")
    end
  end
end