require 'rails_helper'

describe BonusEngine::Api::ReportsController do
  render_views

  let(:user){ create :bonus_engine_user }
  let(:hugo){ create :bonus_engine_user, name: 'Hugo' }
  let(:paco){ create :bonus_engine_user, name: 'Paco' }
  let(:luis){ create :bonus_engine_user, name: 'Luis'}
  let(:event){ create :event }

  before do
    create :point, giver_id: hugo.id, receiver_id: user.id, event_id: event.id
    create :point, giver_id: paco.id, receiver_id: user.id, event_id: event.id
    create :point, giver_id: luis.id, receiver_id: user.id, event_id: event.id
    set_current_user user
  end

  describe '#index' do
    before do
      get :index, event_id: event.id
    end
    it 'Displays a list of received points for an event' do
      expect(JSON.parse(response.body).count).to eql 3
    end
  end
end

