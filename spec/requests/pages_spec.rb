require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /offline" do
    it "returns http success" do
      get "/pages/offline"
      expect(response).to have_http_status(:success)
    end
  end

end
