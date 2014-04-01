$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "user_group/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "user_group"
  s.version     = UserGroup::VERSION
  s.authors     = ["A.K.M. Ashrafuzzaman"]
  s.email       = ["ashrafuzzaman.g2@gmail.com"]
  s.homepage    = ""
  s.summary     = "Manage User Group and roles"
  s.description = "Manage User Group and roles"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency "inherited_resources"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
end