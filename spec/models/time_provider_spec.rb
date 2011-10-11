require 'spec_helper'

describe TimeProvider do
  
  describe "#current_time" do
    
    context "when the time is not set" do
      let(:date_time) { DateTime.parse('Nov 22, 2011') }
      
      before { DateTime.stub(:now).and_return(date_time) } 
      
      it { TimeProvider.current_time.should == date_time }
    end
    
    context "when the time is set" do
      let(:date_time) { DateTime.parse('Nov 28, 2012') }
      
      before { TimeProvider.current_time = date_time } 
      
      it { TimeProvider.current_time.should == date_time }
    end
    
  end
end
