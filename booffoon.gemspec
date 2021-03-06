$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "booffoon/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "booffoon"
  s.version     = Booffoon::VERSION
  s.authors     = ["Wojtek Kruszewski"]
  s.email       = ["wojtek@oxos.pl"]
  s.homepage    = "https://github.com/WojtekKruszewski/booffoon"
  s.summary     = "Form builder for Bootstrap"
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "rails", "~> 5.0.0.alpha"

  s.add_development_dependency "sqlite3"
end
