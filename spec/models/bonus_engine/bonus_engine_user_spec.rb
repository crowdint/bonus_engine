require 'rails_helper'

module BonusEngine
  describe BonusEngineUser do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many :cycles }
  end
end
