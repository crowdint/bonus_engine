module BonusEngine
  class BonusEngineUser < BonusEngine.user_class

    attr_accessor :name
    has_and_belongs_to_many :cycles

    def given_points
      BonusEngine::Point.where giver_id: self.id
    end

    def received_points
      BonusEngine::Point.where receiver_id: self.id
    end

  end
end
