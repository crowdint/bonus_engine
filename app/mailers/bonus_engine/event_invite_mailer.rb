module BonusEngine
  class EventInviteMailer < ActionMailer::Base
    def event_invite(emails, event)
      @event = event
      mail(
        from: 'bonus@crowdint.com',
        to: emails,
        subject: 'Bonus: We want you to make it rain!'
      )
    end
  end
end
