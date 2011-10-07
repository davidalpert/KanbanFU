require 'spec_helper'

describe ProjectsController do

  before(:each) do
    @projects = (1..10).collect {|i| stub_model(Project, :id => i, :name => "project_#{i}", :description => "description_#{i}") }
    @json = {projects: @projects}.to_json(:except => [:project_id, :created_at, :updated_at])
  end

  describe '.index format JSON' do
    before do
      Project.stub(:all).and_return(@projects)
      get :index, :format => :json
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:json) }
    it { response.body.should eq(@json) }
  end

  describe "GET show JSON" do
    before do
      Project.stub(:find_by_id).with('1').and_return(@projects.first)
      get :show, :format => :json, :id => 1
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:json) }
    it { response.body.should eq({project: @projects.first}.to_json(:except => [:created_at, :updated_at])) }

  end

  describe '.create' do
    before do
      project = @projects.first.attributes
      project.delete('created_at')
      project.delete('updated_at')
      @json = {project: project}.to_json
      project.delete('id')
      @new_project = stub_model(Project, project)
      Project.stub(:new).with(project).and_return(@new_project)
      @new_project.should_receive(:save).and_return(true)
      post :create, :format => :json, :project => project
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:json) }
    it { response.body.should be_json_eql(@json) }
  end

end

