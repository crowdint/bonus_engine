require 'rails_helper'

describe BonusEngine::Api::EventsController do
  render_views

  describe "#index" do
    let(:cycle){ create :cycle }
    let(:cycle2){ create :cycle }

    before do
      cycle.events << create(:event, name: 'Cycle1 Event')
      cycle2.events << create(:event, name: 'Cycle2 Event')

      set_current_user cycle.bonus_engine_users.first
      get :index, cycle_id: cycle.id
    end

    it "returns only the events for that cycle" do
      expect(JSON.parse(response.body).count).to be(1)
    end

    it "does not return another cycle's events" do
      expect(JSON.parse(response.body)).not_to include(cycle2.to_json)
    end
  end

  describe '#show' do
    let!(:cycle) { create :cycle, budget: 3000 }
    let!(:event) { create(:event, name: 'test') }

    before do
      cycle.events << event
      hugo = cycle.bonus_engine_users.find(1)
      paco = cycle.bonus_engine_users.find(2)
      luis = cycle.bonus_engine_users.find(3)
      create :point, giver_id: hugo.id, receiver_id: paco.id, event_id: event.id
      create :point, giver_id: paco.id, receiver_id: luis.id, event_id: event.id
      create :point, giver_id: luis.id, receiver_id: paco.id, event_id: event.id

      set_current_user cycle.bonus_engine_users.first
      get :show, id: event.id, cycle_id: cycle.id
    end

    it "returns the event" do
      expect(response.status).to be 200
      expect(event.name).to eq JSON.parse(response.body)["name"]
      expect(JSON.parse(response.body)["bonus_engine_points"].count).to eql 3
      expect(JSON.parse(response.body)["budget"]).to eql 1000
      expect(JSON.parse(response.body)["minimum_people"]).to eql 4
      expect(JSON.parse(response.body)["maximum_points"]).to be > 0
      expect(JSON.parse(response.body)["info"]["balance"]).to be_a Integer
    end
  end
end
