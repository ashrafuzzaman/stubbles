$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "charter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "charter"
  s.version     = Charter::VERSION
  s.authors     = ["A.K.M. Ashrafuzzaman"]
  s.email       = ["ashrafuzzaman.g2@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "A gem to build and render chart on web and as image."
  s.description = "A gem to build chart to show on web as well as get an image out of it."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', ['>= 3.0.0', '< 4.0.0']
  s.add_dependency 'google_visualr', '>= 2.1'
  s.add_dependency 'rmagick'
  s.add_dependency 'gruff'
end
