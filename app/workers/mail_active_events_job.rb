class MailActiveEventsJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 3, backtrace: true

  def perform
    BonusEngine::MailerService.mail_active_events
  end
end

