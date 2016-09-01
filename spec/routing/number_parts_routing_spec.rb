require "rails_helper"

RSpec.describe NumberPartsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/number_parts").to route_to("number_parts#index")
    end

    it "routes to #new" do
      expect(:get => "/number_parts/new").to route_to("number_parts#new")
    end

    it "routes to #show" do
      expect(:get => "/number_parts/1").to route_to("number_parts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/number_parts/1/edit").to route_to("number_parts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/number_parts").to route_to("number_parts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/number_parts/1").to route_to("number_parts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/number_parts/1").to route_to("number_parts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/number_parts/1").to route_to("number_parts#destroy", :id => "1")
    end

  end
end
