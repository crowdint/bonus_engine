attributes :id, :message, :quantity
node(:giver){ |point| point.giver.name }

object @point
