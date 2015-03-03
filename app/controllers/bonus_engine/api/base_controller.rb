module BonusEngine
  module Api
    class BaseController < ApplicationController
      def current_event
        @event ||= BonusEngine::Event.find params[:event_id]
      end

      def current_engine_user
        @current_engine_user ||= BonusEngine::BonusEngineUser.find current_user.id
      end
    end
  end
end
