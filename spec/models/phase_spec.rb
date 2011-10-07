require 'spec_helper'

describe Phase do
  it { should have_db_column(:name).of_type(:string)  }
  it { should have_db_column(:description).of_type(:string) }
end
