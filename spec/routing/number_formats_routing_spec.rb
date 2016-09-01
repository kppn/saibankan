require "rails_helper"

RSpec.describe NumberFormatsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/number_formats").to route_to("number_formats#index")
    end

    it "routes to #new" do
      expect(:get => "/number_formats/new").to route_to("number_formats#new")
    end

    it "routes to #show" do
      expect(:get => "/number_formats/1").to route_to("number_formats#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/number_formats/1/edit").to route_to("number_formats#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/number_formats").to route_to("number_formats#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/number_formats/1").to route_to("number_formats#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/number_formats/1").to route_to("number_formats#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/number_formats/1").to route_to("number_formats#destroy", :id => "1")
    end

  end
end
