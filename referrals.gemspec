$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "referrals/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "referrals"
  s.version     = Referrals::VERSION
  s.authors     = ["psagan"]
  s.email       = ["patryk.sagan@icloud.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Referrals."
  s.description = "TODO: Description of Referrals."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
