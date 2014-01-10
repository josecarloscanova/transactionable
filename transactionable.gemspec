$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "transactionable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "transactionable"
  s.version     = Transactionable::VERSION
  s.authors     = ["Vadim Timoshpolsky"]
  s.email       = ["vadim.timoshpolsky@gmail.com"]
  s.homepage    = "https://github.com/TanookiSuitLabs/transactionable"
  s.summary     = "Instant Balanced marketplace transactions integration"
  s.description = "This Rails engine provides a way to integrate with the Balanced payments platform"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "> 3.1"
  s.add_dependency "balanced", "~> 0.7"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock", "< 1.16"
end
