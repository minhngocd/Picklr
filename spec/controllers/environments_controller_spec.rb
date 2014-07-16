require 'spec_helper'

describe EnvironmentsController do

  let(:environments) { ["qa", "uat"] }
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


  describe "create" do
    it "should redirect to login if user is not logged in" do
      post :create, name: "queue", description: ""
      response.should redirect_to "/users/sign_in"
    end

    it "should create environment" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:create_environment).with("prod")
      post :create, name: "prod"
      flash[:notice].should eq("Environment created!")
      response.should redirect_to "/environments/prod"
    end

    it "should display errors on validation" do
      sign_in :user, user
      expect(EnvironmentsRepository).to_not receive(:create_environment)
      post :create, name: "prod "
      flash[:alert].should include "Name only allows letters, numbers, and underscores"
      response.should redirect_to "/environments/new"
    end

    it "should return 500 if error while trying to create environment" do
      sign_in :user, user
      expect(EnvironmentsRepository).to receive(:create_environment).and_raise(Exception.new "Error message")
      post :create, name: "prod"
      response.status.should == 500
      response.body.should == "Error message"
    end

  end

end