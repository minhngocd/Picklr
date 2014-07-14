require 'spec_helper'

describe FeaturesRepository do

  describe "with data" do
    before do
      FeaturesRepository.create!(name: "test1", description: "description")
      FeaturesRepository.create!(name: "test2", description: "description")
      FeaturesRepository.create!(name: "test3", description: "description")
    end

    it "should find all toggles" do
      all_toggles = FeaturesRepository.all_features
      all_toggles.length.should == 3
      all_toggles.should include "test1"
      all_toggles.should include "test2"
      all_toggles.should include "test3"
    end
  end

  describe "with no data" do
    it "should return empty array" do
      EnvironmentsRepository.all_environments.should == []
    end
  end

  describe "create" do
    it "should create new feature" do
      FeaturesRepository.all_features.length.should == 0
      FeaturesRepository.create_feature("test4", "")
      FeaturesRepository.all_features.length.should == 1
      FeaturesRepository.all_features.first.should == "test4"
    end
  end
end