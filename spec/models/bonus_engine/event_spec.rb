require 'rails_helper'

module BonusEngine
  describe Event do
    it { should belong_to :cycle }
    it { should validate_presence_of :name }
    it { should validate_presence_of :opens_at }
    it { should validate_presence_of :closes_at }
  end
end
