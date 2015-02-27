module BonusEngine
  module Api
    module Admin
      class CyclesController < BaseController
        before_action :find_cycle, only: [:show, :update, :destroy]

        def create
          @cycle = Cycle.new(cycle_params)
          if @cycle.save
            associate_users
            render :show, cycle: @cycle, status: :created
          else
            render json: @cycle.errors, status: :unprocessable_entity
          end
        end

        def destroy
          @cycle.destroy
          render nothing: true, status: :ok
        end

        def index
          @cycles = Cycle.all
        end

        def update
          if @cycle.update(cycle_params)
            associate_users
            render :show, status: :ok
          else
            render json: @cycle.errors, status: :unprocessable_entity
          end
        end

        def show; end

        private

        def associate_users
          users = (params[:bonus_engine_user_ids] || []).map do |bonus_engine_user_ids|
            BonusEngine::BonusEngineUser.find bonus_engine_user_ids
          end
          @cycle.bonus_engine_users = users
        end

        def find_cycle
          @cycle ||= Cycle.find(params[:id])
        end

        def cycle_params
          params.require(:cycle).permit(:name,
            :id,
            :budget,
            :maximum_points,
            :minimum_people,
            :msg_required,
            :minimum_points,
            bonus_engine_user_ids: [])
        end


        def authorize_user
          AuthorizationService.authorize_owner! current_user
        end
      end
    end
  end
end
