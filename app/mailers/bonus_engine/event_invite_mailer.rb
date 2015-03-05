module BonusEngine
  class EventInviteMailer < ActionMailer::Base
    def event_invite(event)
      @event = event

      emails = event.users_with_money.map(&:email)

      mail(
        from: 'bonus@crowdint.com',
        to: emails,
        subject: 'Bonus: We want you to make it rain!'
      ) if emails.any?
    end
  end
end
