require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "yamo"
    gem.summary = %Q{YAML Model Objects}
    gem.description = %Q{Classes for loading schema-validated YAML, and creating nice Ruby-objects with accessors}
    gem.email = "kvs@binarysolutions.dk"
    gem.homepage = "http://github.com/kvs/yamo"
    gem.authors = ["Kenneth Vestergaard Schmidt"]
    gem.add_development_dependency "yard", ">= 0"
    gem.add_dependency('kwalify', '>=0.7.1')
    gem.required_ruby_version = '>= 1.9.1'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
