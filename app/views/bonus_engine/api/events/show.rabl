object @event
attributes :id, :name, :opens_at, :closes_at, :active
node(:budget){ |e| e.event_budget }
node(:minimum_people){ |e| e.event_minimum_people }
node(:maximum_points){ |e| e.event_maximum_points }
node(:minimum_points){ |e| e.event_minimum_points }
node(:msg_required){ |e| e.event_msg_required }

child(:points) do
  attributes :id, :message
  node(:giver){ |point| { name: point.giver.name, id: point.giver.id } }
  node(:receiver){ |point| { name: point.receiver.name, id: point.receiver.id } }
end

node(:info) { |e| e.stats_for(@current_engine_user) }
