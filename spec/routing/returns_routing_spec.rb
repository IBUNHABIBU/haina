require "rails_helper"

RSpec.describe ReturnsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/returns").to route_to("returns#index")
    end

    it "routes to #new" do
      expect(get: "/returns/new").to route_to("returns#new")
    end

    it "routes to #show" do
      expect(get: "/returns/1").to route_to("returns#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/returns/1/edit").to route_to("returns#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/returns").to route_to("returns#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/returns/1").to route_to("returns#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/returns/1").to route_to("returns#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/returns/1").to route_to("returns#destroy", id: "1")
    end
  end
end
