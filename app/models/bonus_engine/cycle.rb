module BonusEngine
  class Cycle < ActiveRecord::Base
    validates_presence_of :name, :budget, :maximum_points, :msg_required
    validates_numericality_of :budget, greater_than: 0
    validates_numericality_of :maximum_points, greater_than: 0

    has_many :events
    has_and_belongs_to_many :bonus_engine_users

  end
end
