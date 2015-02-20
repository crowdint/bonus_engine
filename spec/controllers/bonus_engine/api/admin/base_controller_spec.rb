require "rails_helper"

class  BonusEngine::Api::Admin::DummyController < BonusEngine::Api::Admin::BaseController
  # Dummy controller for testing purposes
end

describe BonusEngine::Api::Admin::DummyController do
  # Reopen controller for testing purposes
  controller do
    def index
      render nothing: true
    end
  end

  context "when user is not admin" do
    let(:user) { create :user }

    before do
      set_current_user(user)
    end

    it "restricts access" do
      expect{
        get :index
      }. to raise_error(BonusEngine::AccessDenied)
    end
  end

  context "when user is not admin" do
    let(:admin) { create :admin_user }

    before do
      set_current_user(admin)
    end

    it "restricts access" do
      get :index
      expect(response.status).to be 200
    end
  end
end
