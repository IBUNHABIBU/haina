require "rails_helper"

RSpec.describe RepairJobsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/repair_jobs").to route_to("repair_jobs#index")
    end

    it "routes to #new" do
      expect(get: "/repair_jobs/new").to route_to("repair_jobs#new")
    end

    it "routes to #show" do
      expect(get: "/repair_jobs/1").to route_to("repair_jobs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/repair_jobs/1/edit").to route_to("repair_jobs#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/repair_jobs").to route_to("repair_jobs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/repair_jobs/1").to route_to("repair_jobs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/repair_jobs/1").to route_to("repair_jobs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/repair_jobs/1").to route_to("repair_jobs#destroy", id: "1")
    end
  end
end
