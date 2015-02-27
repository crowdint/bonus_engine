# This migration comes from bonus_engine (originally 20150113223116)
class CreateBonusEngineEvents < ActiveRecord::Migration
  def change
    create_table :bonus_engine_events do |t|
      t.references :cycle, index: true
      t.string :name
      t.datetime :opens_at
      t.datetime :closes_at
      t.integer :cycle_id

      t.timestamps null: false
    end
  end
end
