require 'spec_helper'

describe EnvironmentsController do

  let(:environments) {[Environment.new("qa"), Environment.new("uat")]}
  before do
  end

  describe "all" do
    it "should show all environments" do
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(environments)
      get :all
      expect(assigns(:environments)).to eq(environments)
      response.should be_success
      response.body.should render_template("all")
    end

  end

end