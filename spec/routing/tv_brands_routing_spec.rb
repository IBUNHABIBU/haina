require "rails_helper"

RSpec.describe TvBrandsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tv_brands").to route_to("tv_brands#index")
    end

    it "routes to #new" do
      expect(get: "/tv_brands/new").to route_to("tv_brands#new")
    end

    it "routes to #show" do
      expect(get: "/tv_brands/1").to route_to("tv_brands#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/tv_brands/1/edit").to route_to("tv_brands#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/tv_brands").to route_to("tv_brands#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tv_brands/1").to route_to("tv_brands#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tv_brands/1").to route_to("tv_brands#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tv_brands/1").to route_to("tv_brands#destroy", id: "1")
    end
  end
end
