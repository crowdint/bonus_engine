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

    private

    def event_budget
      self.budget || self.cycle.budget
    end

    def event_minimum_people
      self.minimum_people || self.cycle.minimum_people
    end
  end
end
