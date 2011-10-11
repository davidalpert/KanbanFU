class TimeProvider
  @@actual_time = nil
  
  def self.current_time
    @@actual_time || DateTime.now
  end
  
  def self.current_time=(actual_time)
    @@actual_time = actual_time
  end

end