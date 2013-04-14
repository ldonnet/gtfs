$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gtfs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name    = 'gtfs'
  gem.version = Gtfs::VERSION
  #gem.date    = Date.today.to_s
 
  gem.summary = 'Load and read GTFS data from zip bundles'
  gem.description = 'gtfs reads GTFS data from a google-compliant Zip bundle 
                     and returns an object representing the CSV data inside'

  gem.homepage    = 'https://github.com/ldonnet/gtfs'
  gem.authors     = ['nerdEd', 'ldonnet']
  gem.email       = ['ed@nerded.net', 'luc.donnet@free.fr']


  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.add_dependency "rails", "~> 3.2.13"
  # gem.add_dependency "jquery-rails"
  gem.add_dependency 'multi_json'
  gem.add_dependency 'rubyzip'

  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'fakeweb'


  gem.add_development_dependency('guard')
  gem.add_development_dependency('guard-rspec')
  gem.add_development_dependency('guard-bundler')
  gem.add_development_dependency('rspec-rails')

  gem.add_development_dependency "sqlite3"                     
end
