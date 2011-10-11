require 'spec_helper'

describe ProjectsController do

  before(:each) do
    @projects = (1..10).collect {|i| stub_model(Project, :id => i, :name => "project_#{i}", :description => "description_#{i}") }
    @json = {projects: @projects}.to_json(:except => exceptions)
  end

  describe '.index ' do
    before do
      Project.stub(:all).and_return(@projects)
      get :index, :format => :json
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:json) }
    it { response.body.should eq(@json) }
  end

  describe ".show" do
    before {Project.stub(:find_by_id).with('1').and_return(@projects.first)}

    context "via HTML" do
      before {get :show, :id => 1}

      it { should respond_with(:success) }
      it { should respond_with_content_type(:html) }
      it { should render_template(:show) }
    end

    context "via JSON" do
      before {get :show, :format => :json, :id => 1}

      it { should respond_with(:success) }
      it { should respond_with_content_type(:json) }
      it { response.body.should eq({project: @projects.first}.to_json(:except => exceptions)) }
    end
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

  describe '.move_card' do
    [:backlog, :analysis, :working, :review, :archive].each_with_index do |p, i|
      let(p) do 
        phase = stub_model(Phase, name: p.to_s, id: i) 
        Phase.stub(:find_by_id).with(i.to_s).and_return(phase)
        phase 
      end
    end

    let(:card) {stub_model(Card)}

    context 'when moving from backlog' do
      before do 
        Card.stub(:find_by_id).with(card.id.to_s).and_return(card)
        #card.should_receive(:update_attribute).with(:phase_id, working.id)
        put :move_card, format: :js, card_id: card.id, phase_id: working.id
      end

      it { should respond_with(:success) }
    end
  end

  def exceptions
    [:project_id, :created_at, :updated_at]
  end
end

