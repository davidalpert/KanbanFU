require 'spec_helper'

describe Phase do
  it { should have_many(:cards).dependent(:destroy) }
  it { should have_db_column(:name).of_type(:string)  }
  it { should have_db_column(:description).of_type(:string) }
  it { should have_db_column(:wip).of_type(:integer) }
  
  describe '.is_archive' do
    subject { Phase.new(name: 'Archive') }
    
    its(:is_archive) { should be_true }
    its(:is_backlog) { should be_false }
  end
  
  describe '.is_backlog' do
    subject { Phase.new(name: 'Backlog') }
    
    its(:is_archive) { should be_false }
    its(:is_backlog) { should be_true  }
  end
  
end
