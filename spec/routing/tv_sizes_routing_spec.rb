require "rails_helper"

RSpec.describe TvSizesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tv_sizes").to route_to("tv_sizes#index")
    end

    it "routes to #new" do
      expect(get: "/tv_sizes/new").to route_to("tv_sizes#new")
    end

    it "routes to #show" do
      expect(get: "/tv_sizes/1").to route_to("tv_sizes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/tv_sizes/1/edit").to route_to("tv_sizes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/tv_sizes").to route_to("tv_sizes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tv_sizes/1").to route_to("tv_sizes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tv_sizes/1").to route_to("tv_sizes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tv_sizes/1").to route_to("tv_sizes#destroy", id: "1")
    end
  end
end
