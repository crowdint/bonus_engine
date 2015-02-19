module BonusEngine
  class Point < ActiveRecord::Base
    belongs_to :event
    belongs_to :giver, class_name: '::BonusEngine::BonusEngineUser'
    belongs_to :receiver, class_name: '::BonusEngine::BonusEngineUser'

    validates_presence_of :quantity, :receiver_id, :giver_id
    validates_numericality_of :quantity, greater_than: 0

    def self.by_receiver_id(receiver_id)
      where(receiver_id: receiver_id)
    end

    def self.by_giver_id(giver_id)
      where(giver_id: giver_id)
    end

  end
end
