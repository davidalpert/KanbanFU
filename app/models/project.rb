class Project < ActiveRecord::Base
  has_many :cards, :dependent => :destroy
end
