module Rubstone
  class GitAction
    def initialize(repository_path)
      @path = repository_path
    end

    def git_clone(repo_url)
      system("git clone #{repo_url} #{@path}")
    end

    def checkout_ref(ref)
      system("cd #{@path} ; git checkout #{ref}")
    end

    def pull
      system("cd #{@path} ; git pull --rebase")
    end
  end
end

