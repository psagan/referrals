require 'money-rails'
require 'kaminari'

module Referrals
  class Engine < ::Rails::Engine
    isolate_namespace Referrals

    # use rspec in rails engine http://bit.ly/2hmeFFY
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.to_prepare do
      ::ApplicationController.helper(Referrals::Engine.helpers)
      ::ApplicationController.send(:include, Referrals::Engine.helpers)

      # Make the implementing application's helpers available to the engine.
      # This is required for the overriding of engine views and helpers to work correctly.
      Referrals::ApplicationController.helper Rails.application.helpers
    end

  end
end
