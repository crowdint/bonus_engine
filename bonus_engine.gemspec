$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bonus_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bonus_engine"
  s.version     = BonusEngine::VERSION
  s.authors     = ["Ivan Calderon, Gilberto Villa"]
  s.email       = ["ivan.calderon@crowdint.com, gilberto.villa@crowdint.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of BonusEngine."
  s.description = "TODO: Description of BonusEngine."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "rabl"
  s.add_dependency 'angularjs-rails'
  s.add_dependency 'angular-rails-templates'
  s.add_dependency 'ng-rails-csrf'
  s.add_dependency 'angular-ui-bootstrap-rails'


  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "jasmine-rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "sqlite3"
  # Rails Assets
  s.add_development_dependency "rails-assets-angular-mocks", ">= 1.3.4"
  s.add_development_dependency "rails-assets-angular-scenario", ">= 1.3.4"

end
