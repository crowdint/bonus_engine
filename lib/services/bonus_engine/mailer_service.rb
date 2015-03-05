module BonusEngine
  class MailerService
    def self.mail_active_events
      BonusEngine::Cycle.all.each do |cycle|
        cycle.active_events.each do |event|
          BonusEngine::EventInviteMailer.event_invite(event).deliver
        end
      end
    end
  end
end
