$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'pokeedex/version'

Gem::Specification.new do |spec|
  spec.name = 'pokeedex'
  spec.version = Pokeedex::VERSION
  spec.authors = ['Guillermo Moreno']
  spec.email = ['jmemox@gmail.com']

  spec.summary = 'A pokedex made in Ruby to obtain information about a Pokemon'
  spec.description = 'A pokedex made in Ruby to obtain information about a Pokemon'
  spec.homepage = 'https://github.com/memoxmrdl/pokeedex'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'
  spec.add_dependency 'base64'
  spec.add_dependency 'forwardable'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'playwright-ruby-client'
  spec.add_dependency 'sequel'
  spec.add_dependency 'sqlite3'

  spec.add_development_dependency 'sdoc', '~> 1.0'

  all_files = `git ls-files`.split("\n")
  test_files = `git ls-files -- {spec}/*`.split("\n")

  spec.files = all_files - test_files
  spec.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = %w[lib]
end
