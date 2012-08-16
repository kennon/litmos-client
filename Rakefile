require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "litmos-client"
  gem.homepage = "http://github.com/kennon/litmos-client"
  gem.license = "MIT"
  gem.version = "0.0.2"
  gem.summary = %Q{Litmos-client is a Ruby wrapper for the Litmos API}
  gem.description = %Q{Litmos-Client is a Ruby gem that provides a wrapper for interacting with the Litmos Learning Management System API.}
  gem.email = "kennon@angryturnip.com"
  gem.authors = ["Kennon Ballou"]
  gem.add_dependency "rest-client"
  gem.add_dependency "json"
  gem.add_dependency "hashugar"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "litmos-client #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
