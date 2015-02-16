require 'rails_helper'

describe BonusEngine::Api::CyclesController do
  render_views
  let!(:user){ create :bonus_engine_user }

  before do
    set_current_user user
  end

  describe "#index" do
    let!(:cycle) { create(:cycle, name: 'test') }
    let(:expected_response) { [{"name" => 'test'}] }

    before do
      cycle.bonus_engine_users << user
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


