# == Schema Information
#
# Table name: page_keywords
#
#  id       :integer          not null, primary key
#  page_id  :integer
#  keywords :text(65535)
#

class PageKeyword < ActiveRecord::Base
end
