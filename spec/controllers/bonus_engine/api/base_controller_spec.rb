require "rails_helper"

class  BonusEngine::Api::DummyController < BonusEngine::Api::BaseController
  # Dummy controller for testing purposes
end

describe BonusEngine::Api::DummyController do
  # Reopen controller for testing purposes
  controller do
    def index
      render nothing: true
    end
  end

  context "when user is not logged in" do

    before do
      get :index
    end

    it { expect(response.body).to be_empty }
  end
end
