require "rails_helper"

RSpec.describe TopsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tops").to route_to("tops#index")
    end

    it "routes to #new" do
      expect(:get => "/tops/new").to route_to("tops#new")
    end

    it "routes to #show" do
      expect(:get => "/tops/1").to route_to("tops#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tops/1/edit").to route_to("tops#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/tops").to route_to("tops#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tops/1").to route_to("tops#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tops/1").to route_to("tops#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tops/1").to route_to("tops#destroy", :id => "1")
    end

  end
end
