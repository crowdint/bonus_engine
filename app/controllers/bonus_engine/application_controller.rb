module BonusEngine
  class ApplicationController < ::ApplicationController
     layout Rails.env.test? ? 'dummy' : 'admin'
  end
end
