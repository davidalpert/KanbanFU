class Card < ActiveRecord::Base
  belongs_to :phase
  validates :title, :presence => true
  validates :phase, :presence => true
  after_initialize :init  
  
  def blocked
    !@block_started.nil?
  end
  
  def block(doit = true)
    @block_started = DateTime.now if doit
    unless doit
      self.blocked_time += (DateTime.now - @block_started) if @block_started
      @block_started = nil
    end
  end
  
  private
    def init
      self.blocked_time ||= 0.0
      self.waiting_time ||= 0.0
    end
  
end
