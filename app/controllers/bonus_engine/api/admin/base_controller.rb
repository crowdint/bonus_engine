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
      end
    end
  end
end
