module BonusEngine
  module Api
    module Admin
      class BaseController < ApplicationController
        before_action :authorize_user

        private

        def authorize_user
          AuthorizationService.authorize_admin! current_user
        end

        def current_event
          @event ||= BonusEngine::Event.find params[:event_id]
        end

        def current_engine_user
          @current_engine_user ||= BonusEngine::BonusEngineUser.find current_user.id
        end
      end
    end
  end
end
