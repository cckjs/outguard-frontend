# == Schema Information
#
# Table name: page_keywords
#
#  id       :integer          not null, primary key
#  page_id  :integer
#  keywords :text(65535)
#

require 'rails_helper'

RSpec.describe PageKeyword, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
