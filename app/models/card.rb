class Card < ActiveRecord::Base
  has_one :phase
  validates :title, :presence => true
end
