# This migration comes from bonus_engine (originally 20150223182840)
class RenameBonusEngineUsersTable < ActiveRecord::Migration
  def change
    rename_table :bonus_engine_bonus_engine_users_cycles, :bonus_engine_cycles_users
  end
end
