require "rails_helper"

RSpec.describe UrlWeightRulesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/url_weight_rules").to route_to("url_weight_rules#index")
    end

    it "routes to #new" do
      expect(:get => "/url_weight_rules/new").to route_to("url_weight_rules#new")
    end

    it "routes to #show" do
      expect(:get => "/url_weight_rules/1").to route_to("url_weight_rules#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/url_weight_rules/1/edit").to route_to("url_weight_rules#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/url_weight_rules").to route_to("url_weight_rules#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/url_weight_rules/1").to route_to("url_weight_rules#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/url_weight_rules/1").to route_to("url_weight_rules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/url_weight_rules/1").to route_to("url_weight_rules#destroy", :id => "1")
    end

  end
end
