json.array!(@url_weight_rules) do |url_weight_rule|
  json.extract! url_weight_rule, :id, :url, :weight, :source, :channel
  json.url url_weight_rule_url(url_weight_rule, format: :json)
end
