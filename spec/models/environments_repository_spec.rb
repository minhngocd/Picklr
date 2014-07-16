require 'spec_helper'

describe EnvironmentsRepository do

  describe "with data" do
    before do
      EnvironmentsRepository.create!(name: "qa")
      EnvironmentsRepository.create!(name: "uat")
      EnvironmentsRepository.create!(name: "prod")
    end

    it "should find all environments" do
      all_environments = EnvironmentsRepository.all_environments
      all_environments.length.should == 3
      all_environments.should include "qa"
      all_environments.should include "uat"
      all_environments.should include "prod"
    end
  end

  describe "create" do
    it "should create new feature" do
      EnvironmentsRepository.all_environments.length.should == 0
      EnvironmentsRepository.create_environment("test")
      EnvironmentsRepository.all_environments.length.should == 1
      EnvironmentsRepository.all_environments.first.should == "test"
    end
  end

  describe "with no data" do
    it "should return empty array" do
      EnvironmentsRepository.all_environments.should == []
    end
  end
end