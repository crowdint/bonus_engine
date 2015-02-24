require 'rails_helper'

describe BonusEngine::Api::Admin::CyclesController do
  render_views

  let(:owner) { create :owner_user }
  let(:hugo){ create :user, name: 'Hugo' }
  let(:paco){ create :user, name: 'Paco' }
  let(:luis){ create :user, name: 'Luis'}

  before do
    set_current_user(owner)
  end

  describe '#create' do
    context 'with valid data' do
      let(:params) do
        {
            cycle: {
                name: 'test',
                bonus_engine_users_attributes: [
                  { id: hugo.id },
                  { id: paco.id },
                  { id: luis.id }
                ]
            }
        }
      end

      before do
        get :create, params
      end

      it 'creates a new cycle' do
        expect(response.status).to be 201
        expect(params[:cycle][:name]).to eq JSON.parse(response.body)["name"]
        expect(BonusEngine::Cycle.first.bonus_engine_users.count).to be > 0
      end
    end

    context 'with invalid data' do
      let(:params) do
        {
            cycle: {
                name: ''
            }
        }
      end

      before do
        get :create, params
      end

      it 'does not create the cycle' do
        expect(response.status).to be 422
      end
    end
  end

  describe '#update' do
    context 'with valid data' do
      let(:cycle) { create :cycle }

      before do
        put :update, id: cycle.id, cycle: { name: 'updated name' }
      end

      it 'updates the cycle' do
        expect(response.status).to be 200
        expect("updated name").to eq JSON.parse(response.body)["name"]
      end
    end

    context 'with invalid data' do
      let(:cycle) { create :cycle }

      before do
        put :update, id: cycle.id, cycle: { name: '' }
      end

      it 'does not update the cycle' do
        expect(response.status).to be 422
      end
    end
  end

  describe '#destroy' do
    let(:cycle) { create(:cycle) }

    before do
      delete :destroy, id: cycle.id
    end

    it 'destroys the specified cycle' do
      expect(response.status).to be 200
    end
  end

  describe "#index" do
    let!(:cycle) { create(:cycle, name: 'test') }
    let(:expected_response) { [{"id" => 1, "name" => 'test'}] }

    before do
      get :index
    end

    it "returns a collection of cycles" do
      expect(response.status).to be 200
      expect(expected_response).to eq JSON.parse(response.body)
    end
  end

  describe '#show' do
    let!(:cycle) { create(:cycle, name: 'test') }

    before do
      get :show, id: cycle.id
    end

    it "returns the cycle" do
      expect(response.status).to be 200
      expect(cycle.name).to eq JSON.parse(response.body)["name"]
    end
  end
end


