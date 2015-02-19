object @point
attributes :id, :message, :quantity, :receiver_id ,:giver_id
node(:info) { {balance: @balance, pending: @pending} }
