#!/usr/bin/env rake
require 'rubygems'
require 'rspec/core/rake_task'

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Gtfs'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

task :default => :spec

namespace :vcr do
  desc "Migrate cassettes from the VCR 1.x format to the VCR 2.x format."
  task :migrate_cassettes do
    dir = ENV.fetch('DIR') { raise "You must pass the cassette library directory as DIR=<directory>" }
    require 'vcr/cassette/migrator'
    VCR::Cassette::Migrator.new(dir).migrate!
  end
end
