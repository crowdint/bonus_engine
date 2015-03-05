require 'rails_helper'

describe MailerService do
  let(:cycle){ create :cycle }
  let(:event){ create :event }
  before do
    cycle.events << event
    expect(BonusEngine::EventInviteMailer).to receive(:event_invite)
  end
  describe '#mail_active_events' do
    it 'calls event invite mailer for active events' do
      MailerService.mail_active_events
    end
  end
end
