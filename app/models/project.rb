class Project < ActiveRecord::Base
  has_many :cards, :dependent => :destroy

  validates :name, :presence => true
end
