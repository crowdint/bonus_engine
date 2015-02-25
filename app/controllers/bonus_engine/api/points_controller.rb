module BonusEngine
  module Api
    class PointsController < BaseController
      before_action :check_msg, only: [:create, :update]
      before_action :check_budget, only: [:create]
      before_action :check_update_budget, only: [:update]

      def index
        @points = event.points
        @points = @points.by_receiver_id(params[:receiver_id]) if params[:receiver_id]
        @points = @points.by_giver_id(params[:giver_id]) if params[:giver_id]
      end

      def create
        @point = BonusEngine::Point.new point_params
        if @point.save
          set_stats
          render :create, status: :created
        else
          render json: @point.errors, status: :unprocessable_entity
        end
      end

      def update
        @point = BonusEngine::Point.find params[:id]

        if @point.update(point_params)
          set_stats
          render :update, status: :ok
        else
          render json: @point.errors, status: :unprocessable_entity
        end

      end

      private

      def check_msg
        unless current_event.msg_required && params[:message].to_s.length >= 20
          render json: {
                          errors: { message: 'Dont be shy... please leave a bonito message' }
                       }, status: :unprocessable_entity
        end
      end

      def check_budget
        unless budget_service.available_budget? params[:quantity].to_i
          render json: {
                          errors: { balance: 'You might be breaking the balance of the universe' }
                       }, status: :unprocessable_entity
        end
      end

      def check_update_budget
         unless budget_service.available_update_budget? params[:quantity].to_i, params[:id]
           render json: {
                           errors: { balance: 'You might be breaking the balance of the universe' }
                        }, status: :unprocessable_entity
         end
      end

      def point_params
        create_params = params.permit(:receiver_id, :event_id, :quantity, :message)
        create_params[:giver_id] = current_user.id
        create_params
      end

      def set_stats
        stats = current_event.stats_for current_engine_user
        @balance, @pending = stats.values_at 'balance', 'pending'
      end

      def budget_service
        ::BudgetService.new current_event, current_engine_user
      end

      def event
        @event ||= BonusEngine::Event.find params[:event_id]
      end
    end
  end
end
