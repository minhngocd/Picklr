require 'spec_helper'

describe FeaturesController do

  let(:environments) { ["qa", "uat"] }
  let(:toggles) { [Toggle.new("queue", "Queue", true, "qa", "description"), Toggle.new("vatu", "VATU", false, "qa", "description")] }
  let(:user) { User.create! email: "test@test.com", password: "password", password_confirmation: "password", admin: true }


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
      expect(TogglesRepository).to receive(:all_for).with("qa").and_return(toggles)
      get :show, env: "qa"
      expect(assigns(:toggles)).to eq(toggles)
      response.should be_success
      response.body.should render_template("show")
    end

    it "should return 404 if environment not found" do
      expect(TogglesRepository).to receive(:all_for).and_return(nil)
      get :show, env: "qa"
      response.should be_not_found
      response.body.should include "Environment does not exist"
    end

    describe "json" do
      it "should render json" do
        expect(TogglesRepository).to receive(:all_for).with("qa").and_return(toggles)
        get :show, env: "qa", format: "json"
        expect(assigns(:toggles)).to eq(toggles)
        response.should be_success
        response.body.should == '{"queue":true,"vatu":false}'
      end

      it "should return 404 if environment not found" do
        expect(TogglesRepository).to receive(:all_for).and_return(nil)
        get :show, env: "qa", format: "json"
        response.should be_not_found
        response.body.should include "Environment does not exist"
      end
    end
  end

  describe "show_toggle" do
    it "should render json for single toggle" do
      expect(TogglesRepository).to receive(:value_for).with("qa", "queue").and_return(true)
      get :show_toggle, env: "qa", feature: "queue", format: "json"
      response.should be_success
      response.body.should == '{"queue":true}'
    end

    it "should return 404 if environment or feature not found" do
      expect(TogglesRepository).to receive(:value_for).and_return(nil)
      get :show_toggle, env: "qa", feature: "queue", format: "json"
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
      response.should redirect_to "/features/qa"
    end

    it "should return 500 if error while trying to update toggle value" do
      sign_in :user, user
      expect(TogglesRepository).to receive(:toggle).with("qa", "queue").and_raise(Exception.new "Error message")
      post :toggle, env: "qa", feature: "queue"
      response.status.should == 500
      response.body.should == "Error message"
    end
  end

  describe "edit feature" do
    it "should return 503 if user is not logged in" do
      get :edit_feature, feature: "queue"
      response.should redirect_to "/users/sign_in"
    end

    it "should show edit page for feature" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(["qa", "uat"])
      expect(TogglesRepository).to receive(:value_for).with("qa", "queue").and_return(true)
      expect(TogglesRepository).to receive(:value_for).with("uat", "queue").and_return(false)
      get :edit_feature, feature: "queue"
      expect(assigns(:environment_toggle_values)).to eq({"qa" => true, "uat" => false})
      response.should be_success
      response.body.should render_template("edit_feature")
    end

    it "should return 404 if feature does not exist" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(["qa", "uat"])
      expect(TogglesRepository).to receive(:value_for).and_return(nil)
      get :edit_feature, feature: "queue"
      response.should be_not_found
      response.body.should == 'Feature does not exist'
    end
  end

  describe "update feature" do
    it "should return 503 if user is not logged in" do
      put :update_feature, feature: "queue", environments: ["qa"]
      response.should redirect_to "/users/sign_in"
    end

    it "should toggle feature toggle for all environments" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(["qa", "uat"])
      expect(TogglesRepository).to receive(:toggle_with_value).with("qa", "queue", true)
      expect(TogglesRepository).to receive(:toggle_with_value).with("uat", "queue", false)
      put :update_feature, feature: "queue", environments: ["qa"]
      flash[:notice].should eq("Feature updated")
      response.should redirect_to "/"
    end

    it "should return 500 if error while trying to update toggle value" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(["qa", "uat"])
      expect(TogglesRepository).to receive(:toggle_with_value).with("qa", "queue", true).and_raise(Exception.new "Error message")
      put :update_feature, feature: "queue", environments: ["qa"]
      response.status.should == 500
      response.body.should == "Error message"
    end
  end

end