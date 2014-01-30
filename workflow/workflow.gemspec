$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "workflow/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "workflow"
  s.version     = Workflow::VERSION
  s.authors     = ["A.K.M. Ashrafuzzaman"]
  s.email       = ["ashrafuzzaman.g2@gmail.com"]
  #s.homepage    = "TODO"
  s.summary     = "Manage Workflow for activerecord models"
  s.description = "Manage Workflow for activerecord models"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3"
  s.add_development_dependency "sqlite3"
end