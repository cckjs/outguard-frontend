# == Schema Information
#
# Table name: url_weight_rule
#
#  id         :integer          not null, primary key
#  url        :string(200)
#  weight     :float(53)
#  source     :string(300)
#  channel    :string(300)
#  created_at :datetime
#  updated_at :datetime
#

class UrlWeightRule < ActiveRecord::Base
  self.table_name = "url_weight_rule"
end
