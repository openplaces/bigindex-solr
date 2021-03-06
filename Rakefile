require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "bigindex-solr"
    gem.summary = %Q{Bootstraps the Solr search server into your Rails application for use with Bigindex. Gem version is based on the Solr version packaged.}
    gem.description = %Q{Solr is an Apache open-source search server based on Lucene Java. This project aims to integrate Solr into your Rails application to work with Bigindex [http://github.com/openplaces/bigindex]}
    gem.email = "bigrecord@openplaces.org"
    gem.homepage = "http://bigrecord.org"
    gem.authors = ["openplaces.org"]
    gem.add_development_dependency "rspec"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bigindex-solr #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
