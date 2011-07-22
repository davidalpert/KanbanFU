require 'spec_helper'

describe CardsController do

  before(:each) do
    @project = stub_model(Project, id: 1, name: "Blazing Saddles", description: "Movie")
    @cards = (1..1).collect {|i| stub_model(Card, :project_id => @project.id, :id => i, :title => "card_#{i}", :description => "description_#{i}") }
    @project.stub(:cards).and_return(@cards)
    @json = {cards: @cards}.to_json(:except => [:project_id, :created_at, :updated_at])
  end

  describe ".index with JSON format" do
    context "resource found" do
      before do
        Project.stub(:find).with(@project.id).and_return(@project)
        get :index, :format => :json, :project_id => @project.id
      end
      
      it { response.body.should eq(@json) }
    end

    context "resource not found" do
      before do
        Project.stub(:find).with(@project.id).and_return(nil)
        get :index, :format => :json, :project_id => @project.id
      end
      
      it { should respond_with :missing }
    end
  end

  describe ".show with JSON format" do
    before do
      card = @project.cards.first
      Project.stub(:find).with(@project.id).and_return(@project)
      Card.stub(:find).with(card.id).and_return(card)
      get :index, :format => :json, :project_id => @project.id, :id => card.id
    end
    
    context "when the resource exists" do
      it { should respond_with :success }
    end
    
    context "when the resource does not exists"  do
      it { should respond_with :missing }
    end
    
    context "when the project does not exist" do 
      it { should respond_with :missing }
    end

  end

end
