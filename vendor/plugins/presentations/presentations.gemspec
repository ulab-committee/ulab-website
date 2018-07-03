# encoding: utf-8

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "presentations/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "presentations"
  s.version     = Presentations::VERSION
  s.authors     = ["Justin Malčić"]
  s.email       = ["j.malcic@me.com"]
  s.homepage    = "https://jmalcic.gitlab.io/gems/presentations"
  s.summary     = "Conference management plugin for Spina."
  s.description = "Presentations is a Spina plugin which allows you to keep track of conference attendees and presentations."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
  s.add_dependency "spina"

  s.add_development_dependency "sqlite3"
end
