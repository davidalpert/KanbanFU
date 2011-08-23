shared_examples_for "any nested resource" do |parent_model, parent_symbol|
    before do
      parent_model.stub(:find_by_id).and_return(nil)
    end

  it "missing parent responds not_found for #index" do
    get :index, :format => :json, parent_symbol => 1
    should respond_with :missing
  end

  it "responds missing for #create" do
    post :create, :format => :json, parent_symbol => 1
    should respond_with :missing
  end

  it "responds missing for #update" do
    put :update, :format => :json, parent_symbol => 1, :id => 1
    should respond_with :missing
  end

  it "responds missing for #destroy" do
    delete :destroy, :format => :json, parent_symbol => 1, :id => 1
    should respond_with :missing
  end
end
