require 'spec_helper'

describe FeaturesRepository do

  describe "with data" do
    before do
      features =
          [{name: "test1", description: "description"},
           {name: "test2", description: "description"},
           {name: "test3", description: "description"}]
      FileIO.write_create_json(features, Settings.features_repo_file)
    end

    describe "all features" do
      it "should find all features" do
        all_features = FeaturesRepository.all_features
        all_features.length.should == 3
        all_features.should include "test1"
        all_features.should include "test2"
        all_features.should include "test3"
      end
    end

    describe "create" do
      it "should append new feature to file" do
        FeaturesRepository.all_features.length.should == 3
        FeaturesRepository.create_feature("test4", "")
        FeaturesRepository.all_features.length.should == 4
        FeaturesRepository.all_features.should include "test4"
      end
    end

    describe "exists" do
      it "should return if feature already exists or not" do
        FeaturesRepository.feature_exists?("test1").should == true
        FeaturesRepository.feature_exists?("test5").should == false
      end
    end
  end

  describe "with no data" do
    before do
      FileIO.write_create_json(nil, Settings.features_repo_file)
    end

    describe "all features" do
      it "should return empty array for empty file" do
        FeaturesRepository.all_features.should == []
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

    describe "exists" do
      it "should return if feature already exists or not" do
        FeaturesRepository.feature_exists?("test1").should == false
      end
    end
  end

  describe "with no file" do
    describe "all features" do
      it "should create file if file doesn't exist" do
        FeaturesRepository.all_features.should == []
        File.exist? Settings.features_repo_file
      end
    end

    describe "create" do
      it "should create new file with feature in it" do
        FeaturesRepository.create_feature("test4", "")
        FeaturesRepository.all_features.length.should == 1
        FeaturesRepository.all_features.first.should == "test4"
        File.exist? Settings.features_repo_file
      end
    end

    describe "exists" do
      it "should return if feature already exists or not" do
        FeaturesRepository.feature_exists?("test1").should == false
      end
    end
  end


  describe "syncing with toggles repository" do
    it "on creation of new feature it should go through all environments and update toggle files with default toggles" do
      FeaturesRepository.create_feature "queue", ""
      EnvironmentsRepository.create_environment "qa"
      TogglesRepository.toggle_with_value "qa", "queue", true
      FeaturesRepository.create_feature "vatu", ""
      toggles = FileIO.load_create_json Settings.toggles_repo_path + "/qa.json"
      toggles['queue'].should == true
      toggles['vatu'].should == false
    end

    it "on creation of new feature it should go through all environments and create toggle file if not exist" do
      FileIO.write_create_json [{name: "qa"}], Settings.environments_repo_file
      (File.exist? Settings.toggles_repo_path + "/qa.json").should == false
      FeaturesRepository.create_feature "queue", ""
      (File.exist? Settings.toggles_repo_path + "/qa.json").should == true
      toggles = FileIO.load_create_json Settings.toggles_repo_path + "/qa.json"
      toggles['queue'].should == false
    end
  end
end