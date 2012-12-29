# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deferred_attribute/version'

Gem::Specification.new do |gem|
  gem.name = "deferred_attribute"
  gem.version = DeferredAttribute::VERSION
  gem.authors = ["Matthew McEachen"]
  gem.email = ["matthew-deferred_attribute@mceachen.org"]
  gem.description = %q{DeferredAttribute makes lazy-initialized ivars easy}
  gem.summary = gem.description
  gem.homepage = "https://github.com/mceachen/deferred_attribute"

  gem.files = `git ls-files`.split($/)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'

end
