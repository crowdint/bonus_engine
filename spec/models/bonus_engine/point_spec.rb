require 'rails_helper'

module BonusEngine
  describe Point do
    it { should belong_to :event }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :giver_id }
    it { should validate_presence_of :receiver_id }
    it { should belong_to :giver }
    it { should belong_to :receiver }
  end
end
