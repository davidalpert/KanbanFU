require 'spec_helper'

describe ProjectsController do

  before(:each) do
    @projects = (1..10).collect {|i| stub_model(Project, :id => i, :name => "project_#{i}", :description => "description_#{i}") }
  end

  describe 'GET on index via JSON' do
    it 'returns the collection of projects' do
      Project.stub(:all).and_return(@projects)
      get :index, :format => :json
      response.body.should eq({projects: @projects}.to_json)
    end
  end

end
