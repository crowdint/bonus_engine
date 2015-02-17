class AddMinimumPointsToBonusEngineEvents < ActiveRecord::Migration
  def change
    add_column :bonus_engine_events, :minimum_points, :integer, default: 1
  end
end
