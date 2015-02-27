attributes :id, :name, :budget, :maximum_points, :minimum_people, :msg_required, :minimum_points

child bonus_engine_users: :bonus_engine_user_ids do
  attributes :id, :name, :email
end

object @cycle
