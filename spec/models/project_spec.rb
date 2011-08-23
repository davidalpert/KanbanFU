require 'spec_helper'

describe Project do
  it { should have_many(:cards).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end
