class WebPageMetaData < ActiveRecord::Base
  self.table_name = "webpage_metadata_parser"

  has_many :page_ranks, foreign_key: :page_id, primary_key: :id, class_name: "PageRank"
  has_many :my_pages, foreign_key: :page_id, primary_key: :id, class_name: "MyPage"
  has_many :page_keywords, foreign_key: :page_id, primary_key: :id, class_name: "PageKeyword"
end