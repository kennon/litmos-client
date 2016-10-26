require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "litmos-client"
  gem.homepage = "http://github.com/kennon/litmos-client"
  gem.license = "MIT"
  gem.version = "0.1.3"
  gem.summary = %Q{Litmos-client is a Ruby wrapper for the Litmos API}
  gem.description = %Q{Litmos-Client is a Ruby gem that provides a wrapper for interacting with the Litmos Learning Management System API.}
  gem.email = "kennon@angryturnip.com"
  gem.authors = ["Kennon Ballou"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test
