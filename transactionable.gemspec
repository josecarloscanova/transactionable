$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "transactionable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "transactionable"
  s.version     = Transactionable::VERSION
  s.authors     = ["Vadim Timoshpolsky"]
  s.email       = ["vadim.timoshpolsky@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Transactionable."
  s.description = "TODO: Description of Transactionable."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency "balanced", "~> 0.7"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
end
