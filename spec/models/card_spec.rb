require 'spec_helper'

describe Card do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:phase) }
  it { should belong_to(:phase) }
  
  it { should have_db_column(:started_on).of_type(:datetime)  }
  it { should have_db_column(:finished_on).of_type(:datetime) }
  it { should have_db_column(:size).of_type(:integer)         }
  it { should have_db_column(:blocked_time).of_type(:float) }
  it { should have_db_column(:waiting_time).of_type(:float) }
  
  its(:waiting_time) { should == 0 }
  its(:blocked_time) { should == 0 }
  its(:size)         { should be_nil }
  its(:blocked)      { should be_false }
  
  describe "#block" do
    context "When the card is not blocked" do
      before { subject.block }
      
      its(:blocked) { should be_true }
    end
    
    context "When the card is blocked" do
      let(:started)  { DateTime.parse('Nov 1 2011') }
      
      let(:finished) { DateTime.parse('Nov 3 2011') }
      
      before do
        DateTime.stub(:now).and_return(started)
        subject.block
        DateTime.stub(:now).and_return(finished)
        subject.block(false) 
      end
      
      its(:blocked)      { should be_false }
      its(:blocked_time) { should == 2 }
    end
    
    context "When the card was blocked before" do
      let(:started)  { DateTime.parse('Nov 1 2011') }
      
      let(:finished) { DateTime.parse('Nov 3 2011') }
      
      subject { Card.new(blocked_time:20) }

      before do
        DateTime.stub(:now).and_return(started)
        subject.block
        DateTime.stub(:now).and_return(finished)
        subject.block(false) 
      end
      
      its(:blocked)      { should be_false }
      its(:blocked_time) { should == 22 }
    end
    
  end
  
end
