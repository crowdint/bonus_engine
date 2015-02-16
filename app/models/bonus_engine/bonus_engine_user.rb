module BonusEngine
  class BonusEngineUser < ActiveRecord::Base

    belongs_to :user, class_name: BonusEngine.user_class.to_s
    has_and_belongs_to_many :cycles
    has_many :points, foreign_key: 'giver_id'

  end
end
