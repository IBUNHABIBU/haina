require "rails_helper"

RSpec.describe SpareRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/spare_requests").to route_to("spare_requests#index")
    end

    it "routes to #new" do
      expect(get: "/spare_requests/new").to route_to("spare_requests#new")
    end

    it "routes to #show" do
      expect(get: "/spare_requests/1").to route_to("spare_requests#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/spare_requests/1/edit").to route_to("spare_requests#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/spare_requests").to route_to("spare_requests#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/spare_requests/1").to route_to("spare_requests#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/spare_requests/1").to route_to("spare_requests#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/spare_requests/1").to route_to("spare_requests#destroy", id: "1")
    end
  end
end
