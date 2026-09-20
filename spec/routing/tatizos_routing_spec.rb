require "rails_helper"

RSpec.describe TatizosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tatizos").to route_to("tatizos#index")
    end

    it "routes to #new" do
      expect(get: "/tatizos/new").to route_to("tatizos#new")
    end

    it "routes to #show" do
      expect(get: "/tatizos/1").to route_to("tatizos#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/tatizos/1/edit").to route_to("tatizos#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/tatizos").to route_to("tatizos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tatizos/1").to route_to("tatizos#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tatizos/1").to route_to("tatizos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tatizos/1").to route_to("tatizos#destroy", id: "1")
    end
  end
end
