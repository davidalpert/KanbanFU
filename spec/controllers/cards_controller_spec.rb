require 'spec_helper'

describe CardsController do

  let(:exceptions) { ['project_id', 'created_at', 'updated_at', 'phase_id'] }
  
  let(:archive) { stub_model(Phase, name: 'archive') }
  let(:backlog) { stub_model(Phase, name: 'backlog') }
  
  let(:project) { stub_model(Project, id: 1, name: "Blazing Saddles", description: "Movie") }
  
  let(:cards) { (1..10).collect { |i| stub_model(Card, 
                                               :project_id => project.id, 
                                               :id => i, 
                                               :title => "card_#{i}", 
                                               :description => "description_#{i}",
                                               :started_on => DateTime.now,
                                               :finished_on => DateTime.now + i,
                                               :size => i,
                                               :phase => archive) } }
  let(:first) { project.cards.first } 

  before(:each) do
    project.stub(:cards).and_return(cards)
    Project.stub(:find_by_id).with(project.id.to_s).and_return(project)

    Card.stub(:find_by_id).with(first.id.to_s).and_return(first)
    project.stub_chain(:cards, :find_by_id).with(first.id.to_s).and_return(first)
  end

  it_behaves_like "any nested resource", Project, :project_id

  describe "#index" do
    context "project found" do
      let(:json) { { cards: adjust(cards) }.to_json(except: exceptions) }
      
      before { get :index, :format => :json, :project_id => project.id }

      it { should respond_with :success }
      it { response.body.should eq(json) }
    end
  end

  describe "#show" do
    let(:json) { { card: adjust(first) }.to_json(:except => exceptions) }
    
    context "when card exists" do
      before  {get :show, :format => :json, :project_id => project.id, :id => first.id}

      it { should respond_with :success }
      it { response.body.should eq(json) }
    end

    context "when card doesn't exist"  do
      before do
        Card.stub(:find_by_id).with(first.id.to_s).and_return(nil)
        get :show, :format => :json, :project_id => project.id, :id => first.id
      end

      it { should respond_with :missing }
    end
  end

  describe '#create' do
    context "when the card is created successfully" do
      let(:card_attributes) { {:title => "card_1", :description => "description_1"} }

      let(:updated) { stub_model(Card, 
                              project_id: project.id,
                              title: 'card_1',
                              description: 'description_1',
                              started_on: DateTime.now,
                              phase: backlog) }
                              
      let(:json) { { card: adjust(updated) }.to_json(except: exceptions) }
      
      before do
        project.stub_chain(:cards, :create).and_return(updated)
        post :create, :format => :json, :project_id => project.id, :card => updated.attributes
      end

      it { should respond_with(:success) }
      it { should respond_with_content_type(:json) }
      it { response.body.should be_json_eql(json) }
    end

    context "when the card is invalid" do
      before do
        project.stub_chain(:cards, :create).and_return(false)
        post :create, :format => :json, :project_id => project.id, :card => {}
      end

      it { should respond_with(:bad_request) }
      it { should respond_with_content_type(:json) }
      it { response.body.should be_json_eql(nil) }
    end
  end

  describe '#update' do
    context "card is updated successfully" do
      let(:updated_card) { stub_model(Card, 
                                      :id => 1, 
                                      :project_id => 1, 
                                      :title => 'updated title', 
                                      :finished_on => first.finished_on,
                                      :phase => first.phase,
                                      :started_on => first.started_on,
                                      :size => first.size,
                                      :description => 'new description') }
      
      let(:json) { {card: adjust(updated_card) }.to_json(except: exceptions) }
      
      before do
        put :update, 
             :format => :json, 
             :project_id => project.id, 
             :id => 1, 
             :card => { :title => updated_card.title, :description => updated_card.description } 
      end

      it { should respond_with(:success) }
      it { should respond_with_content_type(:json) }
      it { response.body.should be_json_eql(json) }
    end

    context "card is not updated" do
      before do
        first.should_receive(:update_attributes).and_return(false)
        put :update, :format => :json, 
            :project_id => project.id, :id => 1, 
            :card => {:title => ''}
      end

      it { should respond_with(:bad_request) }
      it { should respond_with_content_type(:json) }
      it { response.body.should be_json_eql(nil) }
    end
  end

  describe '#delete' do
    let(:second) { project.cards[1] }

    before {Card.stub(:find_by_id).with(second.id.to_s).and_return(second)}

    context "card is deleted successfully" do
      before do
        second.should_receive(:destroy).and_return(true)
        delete :destroy, :format => :json, :project_id => project.id, :id => second.id
      end

      it { should respond_with(:success) }
      it { should respond_with_content_type(:json) }
      it { response.body.should be_json_eql({}) }
    end

    context "card is not deleted" do
      before do
        second.should_receive(:destroy).and_return(false)
        delete :destroy, :format => :json, :project_id => project.id, :id => second.id
      end

      it { should respond_with(:bad_request) }
      it { should respond_with_content_type(:json) }
      it { response.body.should be_json_eql(nil) }
    end
  end

  describe '#block' do
    context 'when card is not blocked' do
      before do
        first.should_receive(:block).with(true)
        put :block, format: :json, project_id: project.id, id: first.id
      end
      
      it { should respond_with(:success) }
      it { should respond_with_content_type(:json) }
      it { response.body.should be_json_eql({}) }
    end
  end
  
  describe '#unblock' do
    context 'when card is blocked' do
      before do
        first.should_receive(:block).with(false)
        put :unblock, format: :json, project_id: project.id, id: first.id
      end

      it { should respond_with(:success) }
      it { should respond_with_content_type(:json) }
      it { response.body.should be_json_eql({}) }
    end
  end

  def adjust(cards) 
    adjusted = [cards].flatten.collect do |c| 
      attrib = c.attributes
      attrib.delete('block_started')
      attrib.merge(phase: c.phase.name, blocked: false) 
    end
    return adjusted if cards.kind_of? Array
    adjusted.first
  end
end
