module BonusEngine
  module Api
    class EventsController < BaseController
      before_action :find_cycle, :current_engine_user

      def index
        @events = @cycle.events
      end

      def show
        @event = @cycle.events.find(params[:id])
      end

      private

      def find_cycle
        @cycle = Cycle.find(params[:cycle_id])
      end
    end
  end
end
