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
end
