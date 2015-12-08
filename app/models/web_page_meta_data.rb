# == Schema Information
#
# Table name: webpage_metadata_parser
#
#  id         :integer          not null, primary key
#  url        :string(600)
#  json       :text(4294967295)
#  updated_at :string(30)
#

class WebPageMetaData < ActiveRecord::Base
  self.table_name = "webpage_metadata_parser"

  has_many :page_ranks, foreign_key: :page_id, primary_key: :id, class_name: "PageRank"
  has_many :my_pages, foreign_key: :page_id, primary_key: :id, class_name: "MyPage"
  has_many :page_keywords, foreign_key: :page_id, primary_key: :id, class_name: "PageKeyword"
end
