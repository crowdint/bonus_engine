require 'rails_helper'

describe BonusEngine::MailerService do
  let(:cycle){ create :cycle }
  let(:event){ create :event }
  before do
    cycle.events << event
    BonusEngine::EventInviteMailer.should_receive(:event_invite).and_return( double("Mailer", deliver: true) )
  end
  describe '#mail_active_events' do
    it 'calls event invite mailer for active events' do
      BonusEngine::MailerService.mail_active_events
    end
  end
end
