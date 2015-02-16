class CreateBonusEngineBonusEngineUsers < ActiveRecord::Migration
  def change
    create_table :bonus_engine_bonus_engine_users do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
