require "rails_helper"

RSpec.describe AllPricesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/all_prices").to route_to("all_prices#index")
    end

    it "routes to #new" do
      expect(get: "/all_prices/new").to route_to("all_prices#new")
    end

    it "routes to #show" do
      expect(get: "/all_prices/1").to route_to("all_prices#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/all_prices/1/edit").to route_to("all_prices#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/all_prices").to route_to("all_prices#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/all_prices/1").to route_to("all_prices#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/all_prices/1").to route_to("all_prices#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/all_prices/1").to route_to("all_prices#destroy", id: "1")
    end
  end
end
