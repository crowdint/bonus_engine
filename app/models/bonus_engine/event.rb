module BonusEngine
  class Event < ActiveRecord::Base
    belongs_to :cycle
    has_many :points

    validates_presence_of :name, :opens_at, :closes_at

    def stats_for(user)
      user_points = user.given_points.where(event_id: id)
      {
        balance: event_budget - user_points.sum(:quantity),
        pending: event_minimum_people - user_points.count
      }
    end

    def active
      opens_at < Time.now && closes_at > Time.now
    end

    def event_budget
      (budget || cycle.budget) / cycle.bonus_engine_users.count
    end

    def event_minimum_people
      minimum_people || cycle.minimum_people
    end

    def event_maximum_points
      maximum_points || cycle.maximum_points
    end

    def event_minimum_points
      minimum_points || cycle.minimum_points
    end

    def event_msg_required
      msg_required || cycle.msg_required
    end

    def users_with_money
      cycle.bonus_engine_users.select{ |u| stats_for(u)[:balance] > 0 }
    end
  end
end
