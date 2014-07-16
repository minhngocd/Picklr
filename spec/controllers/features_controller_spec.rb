require 'spec_helper'

describe FeaturesController do

  let(:user) { User.create! email: "test@test.com", password: "password", password_confirmation: "password", admin: true }

  describe "new" do
    it "should redirect to login if user not logged in" do
      get :new
      response.should redirect_to "/users/sign_in"
    end

    it "should render view if user logged in" do
      sign_in :user, user
      get :new
      response.should be_success
      response.body.should render_template("new")
    end
  end

  describe "edit" do
    it "should redirect to login if user is not logged in" do
      get :edit, feature: "queue"
      response.should redirect_to "/users/sign_in"
    end

    it "should show edit page for feature" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(["qa", "uat"])
      expect(TogglesRepository).to receive(:value_for).with("qa", "queue").and_return(true)
      expect(TogglesRepository).to receive(:value_for).with("uat", "queue").and_return(false)
      get :edit, feature: "queue"
      expect(assigns(:environment_toggle_values)).to eq({"qa" => true, "uat" => false})
      response.should be_success
      response.body.should render_template("edit")
    end

    it "should return 404 if feature does not exist" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(["qa", "uat"])
      expect(TogglesRepository).to receive(:value_for).and_return(nil)
      get :edit, feature: "queue"
      response.should be_not_found
      response.body.should == 'Feature does not exist'
    end
  end

  describe "update" do
    it "should redirect to login if user is not logged in" do
      put :update, feature: "queue", environments: ["qa"]
      response.should redirect_to "/users/sign_in"
    end

    it "should toggle feature toggle for all environments" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(["qa", "uat"])
      expect(TogglesRepository).to receive(:toggle_with_value).with("qa", "queue", true)
      expect(TogglesRepository).to receive(:toggle_with_value).with("uat", "queue", false)
      put :update, feature: "queue", environments: ["qa"]
      flash[:notice].should eq("Feature updated")
      response.should redirect_to "/"
    end

    it "should toggle feature toggle for all environments when nothing checked" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(["qa", "uat"])
      expect(TogglesRepository).to receive(:toggle_with_value).with("qa", "queue", false)
      expect(TogglesRepository).to receive(:toggle_with_value).with("uat", "queue", false)
      put :update, feature: "queue"
      flash[:notice].should eq("Feature updated")
      response.should redirect_to "/"
    end

    it "should return 500 if error while trying to update toggle value" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:all_environments).and_return(["qa", "uat"])
      expect(TogglesRepository).to receive(:toggle_with_value).with("qa", "queue", true).and_raise(Exception.new "Error message")
      put :update, feature: "queue", environments: ["qa"]
      response.status.should == 500
      response.body.should == "Error message"
    end
  end

  describe "create" do
    it "should redirect to login if user is not logged in" do
      post :create, name: "queue", description: ""
      response.should redirect_to "/users/sign_in"
    end

    it "should create feature" do
      sign_in :user, user
      expect(FeaturesRepository).to receive(:create_feature).with("queue","")
      post :create, name: "queue", description: ""
      flash[:notice].should eq("Feature created!")
      response.should redirect_to "/features/queue/edit"
    end

    it "should display errors on validation" do
      sign_in :user, user
      expect(FeaturesRepository).to_not receive(:create_feature)
      post :create, name: "queue ", description: ""
      flash[:alert].should include "Name only allows letters, numbers, and underscores"
      response.should redirect_to "/features/new"
    end

    it "should return 500 if error while trying to update toggle value" do
      sign_in :user, user
      expect(FeaturesRepository).to receive(:create_feature).and_raise(Exception.new "Error message")
      post :create, name: "queue", description: ""
      response.status.should == 500
      response.body.should == "Error message"
    end

  end
end