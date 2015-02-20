module BonusEngine
  module BonusEngineHelpers
    def set_current_user(user)
      ::ApplicationController.class_eval do
        define_method(:current_user) { user }
      end
    end
  end
end
