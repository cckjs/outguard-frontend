# == Schema Information
#
# Table name: filter_words
#
#  id         :integer          not null, primary key
#  word       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FilterWord < ActiveRecord::Base
end
