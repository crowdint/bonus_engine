module BonusEngine
  module Api
    class UsersController < BaseController

      def index
        @users = cycle.users - [current_user]
      end

      def show
        @user = [cycle.bonus_engine_users.find(params[:id]).try(:user)]
      end

      private

      def cycle
        @cycle ||= Cycle.find(params[:cycle_id])
      end

    end
  end
end
