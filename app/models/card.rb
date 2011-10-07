class Card < ActiveRecord::Base
  belongs_to :phase
  validates :title, :presence => true
end
