module BonusEngine
  class Event < ActiveRecord::Base
    belongs_to :cycle
    has_many :points

    validates_presence_of :name, :opens_at, :closes_at

    def stats_for(user)
      user_points = user.given_points.where(event_id: self.id)
      {
        balance: event_budget - user_points.sum(:quantity),
        pending: event_minimum_people - user_points.count
      }
    end

    def active
      opens_at < Time.now && closes_at > Time.now
    end

    def event_budget
      self.budget || self.cycle.budget
    end

    def event_minimum_people
      self.minimum_people || self.cycle.minimum_people
    end

    def event_maximum_points
      self.maximum_points || self.cycle.maximum_points
    end

    def event_msg_required
      self.msg_required || self.cycle.msg_required
    end
  end
end
