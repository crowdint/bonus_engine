class CreateBonusEngineBonusEngineUsersCycles < ActiveRecord::Migration
  def change
    create_table :bonus_engine_bonus_engine_users_cycles do |t|
      t.belongs_to :cycle
      t.belongs_to :bonus_engine_user
    end
  end
end
