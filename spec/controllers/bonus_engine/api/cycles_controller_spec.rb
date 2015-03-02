require 'rails_helper'

describe BonusEngine::Api::CyclesController do
  render_views
  let(:user){ create :bonus_engine_user, name: 'John' }

  before do
    set_current_user user
  end

  describe "#index" do
    let!(:cycle) { create(:cycle, name: 'test') }
    let(:expected_response) { [{"id"=>1,
                                "name"=>"test",
                                "budget"=>2000,
                                "maximum_points"=>400,
                                "minimum_people"=>4,
                                "msg_required"=>true,
                                "minimum_points"=>1,
                                "bonus_engine_user_ids"=>[
                                  {"id" => 2,"name" => 'Hugo',"email" => nil},
                                  {"id" => 3,"name" => 'Paco',"email" => nil},
                                  {"id" => 4,"name" => 'Luis',"email" => nil},
                                  {"id" => 1,"name" => 'John',"email" => nil}
                                ]}
    ] }

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


