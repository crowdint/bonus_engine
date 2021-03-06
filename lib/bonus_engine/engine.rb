require "rabl"

module BonusEngine
  class Engine < ::Rails::Engine
    isolate_namespace BonusEngine

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    config.to_prepare do
      Rails.application.config.engines_list << 'BonusEngine'
    end

    initializer :action_controller do
      ActiveSupport.on_load :action_controller do
        helper BonusEngine::ApplicationHelper
      end
    end
  end
end
