$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "referrals/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "referrals"
  s.version     = Referrals::VERSION
  s.authors     = ["Patryk Sagan"]
  s.email       = ["patryk.sagan@icloud.com"]
  s.homepage    = "https://github.com/psagan/referrals"
  s.summary     = "Referrals engine dedicated for Ruby on Rails based applications"
  s.description = "Responsible for handling referral links and all referral related operations like capture actions, show partner dashboard, payments etc."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4"
  s.add_dependency "money-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
end
