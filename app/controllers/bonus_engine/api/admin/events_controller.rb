module BonusEngine
  module Api
    module Admin
      class EventsController < BaseController
        before_action :find_cycle, :current_engine_user

        def create
          @event = @cycle.events.build event_params
          if @event.save
            render :show, status: :created
          else
            render json: { errors: @event.errors }, status: :unprocessable_entity
          end
        end

        def index
          @events = @cycle.events
        end

        def update
          @event = @cycle.events.find(params[:id])

          if @event.update(event_params)
            render :show, status: :ok
          else
            render json: @event.errors, status: :unprocessable_entity
          end
        end

        def show
          @event = @cycle.events.find(params[:id])
        end

        private

        def find_cycle
          @cycle = Cycle.find(params[:cycle_id])
        end

        def event_params
          params.require(:event).permit(:name, :opens_at, :closes_at, :budget,
                                        :maximum_points, :msg_required,
                                        :minimum_people)
        end
      end
    end
  end
end
