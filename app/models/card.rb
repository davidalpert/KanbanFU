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
    self.block_started = DateTime.now if doit
    unless doit
      self.blocked_time += (DateTime.now - self.block_started.to_datetime).to_f if self.block_started
      self.block_started = nil
    end
  end

  def ready(doit = true)
    self.ready_started = DateTime.now if doit
    unless doit
      self.waiting_time += (DateTime.now - self.ready_started.to_datetime).to_f if self.ready_started
      self.ready_started = nil
    end
  end
  
  private
    def init
      self.blocked_time ||= 0.0
      self.waiting_time ||= 0.0
    end

end
