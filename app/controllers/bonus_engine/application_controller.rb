module BonusEngine
  class ApplicationController < ::ApplicationController
     layout Rails.env.test? ? 'bonus_engine/application' : 'admin'
  end
end
