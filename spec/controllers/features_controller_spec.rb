require 'spec_helper'

describe FeaturesController do

  let(:environments) {[Environment.new("qa"), Environment.new("uat")]}
  let(:toggles) {[Toggle.new("queue", "Queue", true, "qa", "description"), Toggle.new("vatu", "VATU", false, "qa", "description")]}

  describe "all" do
    it "should show all environments" do
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(environments)
      get :all
      expect(assigns(:environments)).to eq(environments)
      response.should be_success
      response.body.should render_template("all")
    end
  end

  describe "show" do
    it "should show all toggles for environment" do
      expect(TogglesValue).to receive(:toggles_for_environment).with("qa").and_return(toggles)
      get :show, env: "qa"
      expect(assigns(:toggles)).to eq(toggles)
      response.should be_success
      response.body.should render_template("show")
    end

    it "should render json" do
      expect(TogglesValue).to receive(:toggles_for_environment).with("qa").and_return(toggles)
      get :show, env: "qa", format: "json"
      expect(assigns(:toggles)).to eq(toggles)
      response.should be_success
      response.body.should == '{"queue":true,"vatu":false}'
    end
  end

  describe "show_toggle" do
    it "should render json for single toggle" do
      expect(TogglesValue).to receive(:toggle_value).with(environment: "qa", feature: "queue").and_return(true)
      get :show_toggle, env: "qa", feature: "queue", format: "json"
      response.should be_success
      response.body.should == '{"queue":true}'
    end
  end

  #TODO: 404 CASES

end