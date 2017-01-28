$:.push File.expand_path("../lib", __FILE__)

require "mybookings_adobe_connect/version"

Gem::Specification.new do |s|
  s.name        = "mybookings_adobe_connect"
  s.version     = MybookingsAdobeConnect::VERSION
  s.authors     = ["Jesús Manuel García Muñoz"]
  s.email       = ["jesus@deliriumcoder.com"]
  s.homepage    = "http://www.deliriumcoder.com/"
  s.summary     = ""
  s.description = ""
  s.license     = ""

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.7.1"
  s.add_dependency "adobe_connect", "1.0.4"
end
