# == Schema Information
#
# Table name: my_pages
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MyPage < ActiveRecord::Base
end
