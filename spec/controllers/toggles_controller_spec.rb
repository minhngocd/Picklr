require 'spec_helper'

describe TogglesController do

  let(:toggles) { [Toggle.new("queue", "Queue", true, "qa", "description"), Toggle.new("vatu", "VATU", false, "qa", "description")] }

  describe "all" do
    it "should show all toggles for environment" do
      expect(TogglesRepository).to receive(:all_for).with("qa").and_return(toggles)
      get :all, env: "qa"
      expect(assigns(:toggles)).to eq(toggles)
      response.should be_success
      response.body.should render_template("all")
    end

    it "should return 404 if environment not found" do
      expect(TogglesRepository).to receive(:all_for).and_return(nil)
      get :all, env: "qa"
      response.should be_not_found
      response.body.should include "Environment does not exist"
    end

    describe "json" do
      it "should render json" do
        expect(TogglesRepository).to receive(:all_for).with("qa").and_return(toggles)
        get :all, env: "qa", format: "json"
        expect(assigns(:toggles)).to eq(toggles)
        response.should be_success
        response.body.should == '{"queue":true,"vatu":false}'
      end

      it "should return 404 if environment not found" do
        expect(TogglesRepository).to receive(:all_for).and_return(nil)
        get :all, env: "qa", format: "json"
        response.should be_not_found
        response.body.should include "Environment does not exist"
      end
    end
  end

  describe "show" do
    it "should render json for single toggle" do
      expect(TogglesRepository).to receive(:value_for).with("qa", "queue").and_return(true)
      get :show, env: "qa", feature: "queue", format: "json"
      response.should be_success
      response.body.should == '{"queue":true}'
    end

    it "should return 404 if environment or feature not found" do
      expect(TogglesRepository).to receive(:value_for).and_return(nil)
      get :show, env: "qa", feature: "queue", format: "json"
      response.should be_not_found
      response.body.should == 'Environment or Feature does not exist'
    end
  end
end