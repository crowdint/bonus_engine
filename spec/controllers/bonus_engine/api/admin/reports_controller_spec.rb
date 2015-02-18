require 'rails_helper'

describe BonusEngine::Api::Admin::ReportsController do
  render_views

  let(:admin) { create(:admin_user) }

  let(:user){ create :bonus_engine_user }
  let(:hugo_usr){ create :user, name: 'hugo' }
  let(:hugo){ create :bonus_engine_user, user_id: hugo_usr.id }
  let(:paco_usr){ create :user, name: 'paco' }
  let(:paco){ create :bonus_engine_user, user_id: paco_usr.id }
  let(:luis_usr){ create :user, name: 'luis' }
  let(:luis){ create :bonus_engine_user, user_id: luis_usr.id }
  let(:event){ create :event }

  before do
    create :point, giver_id: hugo.id, receiver_id: user.id, event_id: event.id
    create :point, giver_id: paco.id, receiver_id: user.id, event_id: event.id
    create :point, giver_id: luis.id, receiver_id: user.id, event_id: event.id
    set_current_user admin
  end

  describe '#index' do
    before do
      get :index, event_id: event.id
    end
    it 'displays a list of received points for an event' do
      expect(response.status).to be 200
    end
  end
end
