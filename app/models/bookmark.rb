class Bookmark < ActiveRecord::Base
  validates :url, :title, :user_id, :presence => true
  belongs_to :user
end
