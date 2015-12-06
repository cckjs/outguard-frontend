require 'rails_helper'

RSpec.describe "url_weight_rules/index", type: :view do
  before(:each) do
    assign(:url_weight_rules, [
      UrlWeightRule.create!(
        :url => "Url",
        :weight => 1,
        :source => "Source",
        :channel => "Channel"
      ),
      UrlWeightRule.create!(
        :url => "Url",
        :weight => 1,
        :source => "Source",
        :channel => "Channel"
      )
    ])
  end

  it "renders a list of url_weight_rules" do
    render
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Channel".to_s, :count => 2
  end
end
