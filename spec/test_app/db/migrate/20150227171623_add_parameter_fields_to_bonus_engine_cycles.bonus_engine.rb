# This migration comes from bonus_engine (originally 20150219183608)
class AddParameterFieldsToBonusEngineCycles < ActiveRecord::Migration
  def change
    add_column :bonus_engine_cycles, :budget, :integer, default: 2000
    add_column :bonus_engine_cycles, :maximum_points, :integer, default: 400
    add_column :bonus_engine_cycles, :minimum_people, :integer, default: 5
    add_column :bonus_engine_cycles, :msg_required, :boolean, default: true
    add_column :bonus_engine_cycles, :minimum_points, :integer, default: 1
  end
end
