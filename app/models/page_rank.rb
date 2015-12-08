# == Schema Information
#
# Table name: page_rank
#
#  id          :integer          not null, primary key
#  page_id     :integer
#  weight      :float(53)
#  publishtime :string(30)
#

class PageRank< ActiveRecord::Base
  self.table_name = "page_rank"
end
