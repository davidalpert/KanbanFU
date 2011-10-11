class Phase < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  
  def is_archive
    self.name.downcase == 'archive'
  end
  
  def is_backlog
    self.name.downcase == 'backlog'
  end

end
