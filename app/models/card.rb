class Card < ActiveRecord::Base
  belongs_to :phase
  validates :title, :presence => true
  validates :phase, :presence => true
  after_initialize :init  
  
  def blocked
    false
  end
  
  private
    def init
      self.blocked_time ||= 0
      self.waiting_time ||= 0
    end
  
end
