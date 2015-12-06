require 'rails_helper'

RSpec.describe "UrlWeightRules", type: :request do
  describe "GET /url_weight_rules" do
    it "works! (now write some real specs)" do
      get url_weight_rules_path
      expect(response).to have_http_status(200)
    end
  end
end
