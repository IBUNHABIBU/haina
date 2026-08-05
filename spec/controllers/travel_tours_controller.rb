require 'rails_helper'

RSpec.describe TravelToursController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Test Tour',
      category: 'Adventure',
      duration: 7,
      price: 299.99,
      description: 'Test description'
    }
  end

  describe 'GET #new' do
    it 'assigns a new travel_tour' do
      get :new
      expect(assigns(:travel_tour)).to be_a_new(TravelTour)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new TravelTour' do
        expect {
          post :create, params: { travel_tour: valid_attributes }
        }.to change(TravelTour, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create a new TravelTour' do
        expect {
          post :create, params: { travel_tour: { name: '' } }
        }.not_to change(TravelTour, :count)
      end
    end
  end
end