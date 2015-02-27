module BonusEngine
  module ApplicationHelper
    def show_active_bonus_events
      event_list = ""
      active_user_events.each do |event|
        event_link = link_to event.name, "/cycles/#{event.cycle_id}/events/#{event.id}"
        event_list.concat content_tag( :li, event_link)
      end
      event_list.html_safe
    end

    private

    def engine_user
      @engine_user ||= BonusEngine::BonusEngineUser.find current_user
    end

    def active_user_events
      active_events = []
      engine_user.cycles.each{ |cycle| active_events << cycle.active_events }
      active_events.flatten!
    end
  end
end
