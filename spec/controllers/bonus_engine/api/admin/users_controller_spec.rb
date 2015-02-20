require 'rails_helper'

describe BonusEngine::Api::Admin::UsersController do
  render_views

  let(:admin) { create :admin_user }

  before do
    set_current_user(admin)
  end

  describe '#index' do
    let!(:user1) { create :user }

    before do
      get :index
    end

    it 'returns all the users' do
      expect(response.status).to be(200)
      expect(JSON.parse(response.body).count).to be(2)
    end
  end

  describe '#show' do
    let!(:user) { create :user }

    before do
      get :show, id: user.id
    end

    it 'returns the specified user' do
      expect(response.status).to be 200
      expect(user.name).to eq JSON.parse(response.body)["name"]
    end
  end

  describe '#create' do
    it 'raises route not found exception' do
      expect {
        post :create
      }.to raise_exception(ActionController::UrlGenerationError)
    end
  end

  describe '#update' do
    it 'raises route not found exception' do
      expect {
        put :update
      }.to raise_exception(ActionController::UrlGenerationError)
    end
  end
end
