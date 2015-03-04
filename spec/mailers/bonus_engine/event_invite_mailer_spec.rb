require "rails_helper"

module BonusEngine
  describe EventInviteMailer do
    let!(:cycle){ create :cycle }
    let!(:event){ create :event }

    before do
      hugo = cycle.bonus_engine_users.find_by id: 1
      paco = cycle.bonus_engine_users.find_by id: 2
      luis = cycle.bonus_engine_users.find_by id: 3
      create :point, giver_id: hugo.id, receiver_id: paco.id, event_id: event.id
      create :point, giver_id: hugo.id, receiver_id: luis.id, event_id: event.id
      create :point, giver_id: luis.id, receiver_id: paco.id, event_id: event.id
      cycle.events << event
    end

    describe '#event_invite' do
      let(:email) do
        EventInviteMailer.event_invite(event)
      end

      it { expect(email.from).to eq ['bonus@crowdint.com'] }
      it { expect(email.to).to eq ['paco@test.com', 'luis@test.com'] }
      it { expect(email.subject).to eq 'Bonus: We want you to make it rain!' }
      it { expect(email.body).to match /Make it rain/ }
    end
  end
end
