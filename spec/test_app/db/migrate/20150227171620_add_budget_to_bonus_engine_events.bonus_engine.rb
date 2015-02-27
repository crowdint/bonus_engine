# This migration comes from bonus_engine (originally 20150210170049)
class AddBudgetToBonusEngineEvents < ActiveRecord::Migration
  def change
    add_column :bonus_engine_events, :budget, :integer
    add_column :bonus_engine_events, :maximum_points, :integer
    add_column :bonus_engine_events, :minimum_people, :integer
    add_column :bonus_engine_events, :msg_required, :boolean, default: true
  end
end
