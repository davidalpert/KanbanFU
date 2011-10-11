class Card < ActiveRecord::Base
  belongs_to :phase
  validates :title, :presence => true
  validates :phase, :presence => true
  after_initialize :init  
  attr_protected :block_started
  
  def blocked
    !self.block_started.nil?
  end
  
  def waiting
    !self.ready_started.nil?
  end

  def block(doit = true)
    self.block_started = TimeProvider.current_time if doit
    ready(false) if doit
    unless doit
      self.blocked_time += (TimeProvider.current_time - self.block_started.to_datetime).to_f if self.block_started
      self.block_started = nil
    end
  end

  def ready(doit = true)
    self.ready_started = TimeProvider.current_time if doit
    block(false) if doit
    unless doit
      self.waiting_time += (TimeProvider.current_time - self.ready_started.to_datetime).to_f if self.ready_started
      self.ready_started = nil
    end
  end
  
  private
    def init
      self.blocked_time ||= 0.0
      self.waiting_time ||= 0.0
    end

end
