require 'rails_helper'

RSpec.describe "url_weight_rules/show", type: :view do
  before(:each) do
    @url_weight_rule = assign(:url_weight_rule, UrlWeightRule.create!(
      :url => "Url",
      :weight => 1,
      :source => "Source",
      :channel => "Channel"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/Channel/)
  end
end
