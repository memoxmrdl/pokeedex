# frozen_string_literal: true

require 'bundler/gem_tasks'
# require 'sequel'
# require 'yaml'
require 'rake'
require 'sdoc'
require 'rdoc/task'

require 'standard/rake'

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'doc/'
  rdoc.options << '--format=sdoc'
  rdoc.options << '--exclude=spec'
  rdoc.rdoc_files.include('README.md', 'lib/**/*.rb')
  rdoc.template = 'rails'
end

task default: %i[standard]
