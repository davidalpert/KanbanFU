require 'spec_helper'

describe CardsController do

  before(:each) do
    @project = stub_model(Project, id: 1, name: "Blazing Saddles", description: "Movie")
    @cards = (1..10).collect {|i| stub_model(Card, :project_id => @project.id, :id => i, :title => "card_#{i}", :description => "description_#{i}") }
    @project.stub(:cards).and_return(@cards)
  end

  describe "GET on 'index' via JSON" do
    it "returns the collection of cards" do
      Project.stub(:find).with(@project.id).and_return(@project)
      get :index, :format => :json, :project_id => @project.id
      response.body.should eq({cards: @cards}.to_json)
    end

    it "returns an error when the project does not exist" do
      Project.stub(:find).with(@project.id).and_return(nil)
      get :index, :format => :json, :project_id => @project.id
      should respond_with 404
    end
  end

end
