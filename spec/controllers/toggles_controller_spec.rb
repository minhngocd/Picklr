require 'spec_helper'

describe TogglesController do

  let(:qa) { Environment.new "qa" }
  let(:vatu) { ApplicationFeature.new "vatu", "description" }
  let(:queue) { ApplicationFeature.new "queue", "description" }
  let(:toggles) { [Toggle.new(queue, qa, true), Toggle.new(vatu, qa, false)] }
  let(:user) { User.create! email: "test@test.com", password: "password", password_confirmation: "password", admin: true }

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


  describe "toggle" do
    it "should return 503 if user is not logged in" do
      post :toggle, env: "qa", feature: "queue"
      response.should redirect_to "/users/sign_in"
    end

    it "should toggle feature toggle" do
      sign_in :user, user
      expect(TogglesRepository).to receive(:toggle).with("qa", "queue")
      post :toggle, env: "qa", feature: "queue"
      response.should redirect_to "/environments/qa"
    end

    it "should return 500 if error while trying to update toggle value" do
      sign_in :user, user
      expect(TogglesRepository).to receive(:toggle).with("qa", "queue").and_raise(Exception.new "Error message")
      post :toggle, env: "qa", feature: "queue"
      response.status.should == 500
      response.body.should == "Error message"
    end
  end

end