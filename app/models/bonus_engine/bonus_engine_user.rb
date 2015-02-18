module BonusEngine
  class BonusEngineUser < ActiveRecord::Base

    belongs_to :user, class_name: BonusEngine.user_class.to_s
    has_and_belongs_to_many :cycles
    delegate :name, to: :user

    def given_points
      BonusEngine::Point.where giver_id: self.id
    end

    def received_points
      BonusEngine::Point.where receiver_id: self.id
    end

  end
end
