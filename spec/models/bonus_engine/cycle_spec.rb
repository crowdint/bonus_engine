require "rails_helper"

module BonusEngine
  describe Cycle do
    it { should validate_presence_of :name }
    it { should have_many :events }
    it { should have_and_belong_to_many :bonus_engine_users }
  end
end
