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

require 'rails_helper'

RSpec.describe UrlWeightRule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
