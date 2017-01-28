$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mybookings_adobe_connect/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mybookings_adobe_connect"
  s.version     = MybookingsAdobeConnect::VERSION
  s.authors     = ["Jesús Manuel García Muñoz"]
  s.email       = ["jesus@deliriumcoder.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MybookingsAdobeConnect."
  s.description = "TODO: Description of MybookingsAdobeConnect."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency "sqlite3"
end
