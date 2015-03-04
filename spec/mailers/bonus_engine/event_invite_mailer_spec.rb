require "rails_helper"

module BonusEngine
  describe EventInviteMailer do
    let!(:cycle){ create :cycle }
    let!(:event){ create :event }
    before do
      cycle.events << event
    end
    describe '#event_invite' do
      let(:emails) { ['test@test.com', 'test2@test.com'] }
      let(:email) do
        EventInviteMailer.event_invite(emails, event)
      end

      it { expect(email.from).to eq ['bonus@crowdint.com'] }
      it { expect(email.to).to eq emails }
      it { expect(email.subject).to eq 'Bonus: We want you to make it rain!' }
      it { expect(email.body).to match /Make it rain/ }
    end
  end
end
