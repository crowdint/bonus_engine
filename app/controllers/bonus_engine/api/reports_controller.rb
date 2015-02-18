module BonusEngine
  module Api
    class ReportsController < BaseController
      def index
        @points = current_user.received_points.where event_id: current_event.id
      end
    end
  end
end
