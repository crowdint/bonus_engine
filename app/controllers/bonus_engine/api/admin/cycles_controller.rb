module BonusEngine
  module Api
    module Admin
      class CyclesController < BaseController
        before_action :find_cycle, only: [:show, :update, :destroy]

        def create
          @cycle = Cycle.new(cycle_params)
          if @cycle.save && associate_users
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
            render :show, status: :ok
          else
            render json: @cycle.errors, status: :unprocessable_entity
          end
        end

        def show; end

        private

        def associate_users
          users_params[:bonus_engine_users_attributes].each do |u|
            user = BonusEngine::BonusEngineUser.find u['id']
            @cycle.bonus_engine_users << user
            @cycle.save
          end
        end

        def find_cycle
          @cycle = Cycle.find(params[:id])
        end

        def cycle_params
          params.require(:cycle).permit(:name)
        end

        def users_params
          params.require(:cycle).permit(bonus_engine_users_attributes: :id)
        end

        def authorize_user
          AuthorizationService.authorize_owner! current_user
        end
      end
    end
  end
end
