require 'rails_helper'

RSpec.describe "ActivityVersions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/activity_versions/index"
      expect(response).to have_http_status(:success)
    end
  end

end
