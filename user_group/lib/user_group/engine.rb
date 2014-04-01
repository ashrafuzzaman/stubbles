module UserGroup
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.orm :active_record
      g.template_engine :erb
      g.test_framework :rspec
      g.integration_tool :rspec
      g.fixture_replacement :factory_girl
      g.stylesheets = false
      g.javascripts = false
      g.scaffold_controller = :scaffold_controller
    end
  end
end