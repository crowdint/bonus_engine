module BonusEngine
  module Api
    class UsersController < BaseController

      def index
        @users = cycle.bonus_engine_users - [current_engine_user]
      end

      def show
        @user = cycle.bonus_engine_users.find(params[:id])
      end

      def me
        @user = current_user
      end

      private

      def cycle
        @cycle ||= Cycle.find(params[:cycle_id])
      end

    end
  end
end
