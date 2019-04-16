# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rubstone/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["shinji-yoshida"]
  gem.email         = ["yoshida.shinji.gm@gmail.com"]
  gem.description   = %q{Library manager for unity3d}
  gem.summary       = %q{Library manager for unity3d}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rubstone"
  gem.require_paths = ["lib"]
  gem.version       = Rubstone::VERSION
end
