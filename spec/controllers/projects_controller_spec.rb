require 'spec_helper'

describe ProjectsController do

  before(:each) do
    @projects = (1..1).collect {|i| stub_model(Project, :id => i, :name => "project_#{i}", :description => "description_#{i}") }
  end

  describe '.index format JSON' do
    before do 
      Project.stub(:all).and_return(@projects)
      get :index, :format => :json
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:json) }
    it { response.body.should eq({projects: @projects}.to_json) }
  end

end
