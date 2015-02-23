module BonusEngine
  module Api
    class CyclesController < BaseController
      before_action :find_cycle, only: :show

      def index
        @cycles = current_user.cycles
      end

      def show; end

      private

      def find_cycle
        @cycle = Cycle.find(params[:id])
      end
    end
  end
end
