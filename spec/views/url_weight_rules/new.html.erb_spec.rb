require 'rails_helper'

RSpec.describe "url_weight_rules/new", type: :view do
  before(:each) do
    assign(:url_weight_rule, UrlWeightRule.new(
      :url => "MyString",
      :weight => 1,
      :source => "MyString",
      :channel => "MyString"
    ))
  end

  it "renders new url_weight_rule form" do
    render

    assert_select "form[action=?][method=?]", url_weight_rules_path, "post" do

      assert_select "input#url_weight_rule_url[name=?]", "url_weight_rule[url]"

      assert_select "input#url_weight_rule_weight[name=?]", "url_weight_rule[weight]"

      assert_select "input#url_weight_rule_source[name=?]", "url_weight_rule[source]"

      assert_select "input#url_weight_rule_channel[name=?]", "url_weight_rule[channel]"
    end
  end
end
