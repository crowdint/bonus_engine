object @event
attributes :name, :opens_at, :closes_at

child(:points) do
  attributes :id, :message
  node(:giver){ |point| { name: point.giver.name, id: point.giver.id } }
  node(:receiver){ |point| { name: point.receiver.name, id: point.receiver.id } }
end
