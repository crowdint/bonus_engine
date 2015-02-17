require 'rails_helper'

describe BonusEngine::Api::PointsController do
  render_views
  let!(:cycle) { create :cycle }
  let!(:event) { create(:event, name: 'test') }
  let!(:givencio) { create(:user, name: 'Givencio') }
  let!(:giver) { create :bonus_engine_user }
  let!(:receiver) { create(:user, name: 'Recibencio') }
  let(:create_params){
    {
      event_id: event.id,
      receiver_id: receiver.id,
      quantity: 400,
      message: 'lorem ipsum dolo'
    }
  }

  before do
    cycle.events << event
    set_current_user giver
  end

  describe '#create' do
    context 'with good arguments' do
      before do
        post :create, create_params
      end

      it 'creates points for a user' do
        expect(response.status).to be 201
        expect(JSON.parse(response.body)['info']).to include('balance')
        expect(BonusEngine::Point.count).to be > 0
      end
    end

    context 'with bad argunents' do
      before do
        create_params[:quantity] = 0
        post :create, create_params
      end

      it 'should not create poins for user' do
        expect(response.status).to be 422
        expect(BonusEngine::Point.count).to be 0
      end
    end

    context 'user cannot spend more budget than assigned' do
      before do
        create :point, receiver_id: 3, event_id: event.id
        create :point, receiver_id: 4, event_id: event.id
        create :point, receiver_id: 5, event_id: event.id
        create :point, receiver_id: 8, event_id: event.id

        post :create, create_params
      end
      it 'wont create points beyond budget' do
        expect(response.status).to be 422
      end
    end

    context 'user should respect maximum money limit' do
      before do
        event.update_attribute :maximum_points, 100
        post :create, create_params
      end

      it 'wont create points beyont maximum limit' do
        expect(response.status).to be 422
      end
    end

    context 'user should respect minimum money limit' do
      before do
        event.update_attribute :minimum_points, 100
        create_params[:quantity] = 99
        post :create, create_params
      end

      it 'wont create point under the minimum limit' do
        expect(response.status).to be 422
      end
    end

    context 'when message is mandatory' do
      before do
        event.update_attribute :msg_required, true
        create_params[:message] = nil
        post :create, create_params
      end
      it 'should not allow to create empty message points' do
        expect(response.status).to be 422
      end
    end
  end

  describe '#update' do
    context 'with good arguments' do
      let!(:existing_point){ create :point }
      before do
        put :update, event_id: 1, id: existing_point.id, message: 'kidding'
        existing_point.reload
      end

      it 'updates attributes' do
        expect(existing_point.message).to be_eql 'kidding'
        expect(JSON.parse(response.body)['info']).to include('balance')
        expect(response.status).to be 200
      end
    end

    context 'with bad arguments' do
      let!(:existing_point){ create :point }
      before do
        put :update, event_id: 1, id: existing_point.id, quantity: 0
        existing_point.reload
      end

      it 'updates attributes' do
        expect(response.status).to be 422
      end
    end

    context 'user can update previously assigned points' do
      before do
        create :point, receiver_id: 3, event_id: event.id
        create :point, receiver_id: 4, event_id: event.id
        create :point, receiver_id: 5, event_id: event.id
        create :point, receiver_id: 8, event_id: event.id

        put :update, event_id: event.id, id: 1, quantity: 10, message: 'test'
      end
      it 'wont create points beyond budget' do
        expect(response.status).to be 200
      end
    end

    context 'user cannot spend more money than budget' do
      before do
        create :point, receiver_id: 3, event_id: event.id
        create :point, receiver_id: 4, event_id: event.id
        create :point, receiver_id: 5, event_id: event.id
        create :point, receiver_id: 8, event_id: event.id

        put :update, event_id: event.id, id: 1, quantity: 1000
      end
      it 'wont create points beyond budget' do
        expect(response.status).to be 422
      end
    end
  end
end
