module BonusEngine
  module Api
    module Admin
      class ReportsController < BaseController
        def index
          @points = BonusEngine::Point.where event_id: current_event.id
          render json: @points
        end
      end
    end
  end
end
