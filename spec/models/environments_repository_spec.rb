require 'spec_helper'

describe EnvironmentsRepository do

  describe "with data" do
    before do
      environments = [{name: "qa"},{name: "uat"},{name: "prod"}]
      FileIO.write_create_json(environments, Settings.environments_repo_file)
    end

    describe "all environments" do
      it "should find all environments" do
        all_environments = EnvironmentsRepository.all_environments
        all_environments.length.should == 3
        all_environments.should include "qa"
        all_environments.should include "uat"
        all_environments.should include "prod"
      end
    end

    describe "create" do
      it "should append new environments to file" do
        EnvironmentsRepository.all_environments.length.should == 3
        EnvironmentsRepository.create_environment "test"
        EnvironmentsRepository.all_environments.length.should == 4
        EnvironmentsRepository.all_environments.should include "test"
      end
    end

    describe "exists" do
      it "should return if environment already exists or not" do
        EnvironmentsRepository.environment_exists?("qa").should == true
        EnvironmentsRepository.environment_exists?("something").should == false
      end
    end
  end

  describe "with no data" do
    before do
      FileIO.write_create_json(nil, Settings.environments_repo_file)
    end

    describe "all environments" do
      it "should return empty array for empty file" do
        EnvironmentsRepository.all_environments.should == []
      end
    end

    describe "create" do
      it "should create new environment" do
        EnvironmentsRepository.all_environments.length.should == 0
        EnvironmentsRepository.create_environment("test")
        EnvironmentsRepository.all_environments.length.should == 1
        EnvironmentsRepository.all_environments.first.should == "test"
      end
    end

    describe "exists" do
      it "should return if environment already exists or not" do
        EnvironmentsRepository.environment_exists?("test").should == false
      end
    end
  end

  describe "with no file" do
    describe "all environments" do
      it "should create file if file doesn't exist" do
        EnvironmentsRepository.all_environments.should == []
        File.exist? Settings.environments_repo_file
      end
    end

    describe "create" do
      it "should create new file with environment in it" do
        EnvironmentsRepository.create_environment "test"
        EnvironmentsRepository.all_environments.length.should == 1
        EnvironmentsRepository.all_environments.first.should == "test"
        File.exist? Settings.environments_repo_file
      end
    end

    describe "exists" do
      it "should return if environment already exists or not" do
        EnvironmentsRepository.environment_exists?("test").should == false
      end
    end
  end

  describe "syncing with toggles repository" do
    it "on creation of new environment it should create a new toggle file with default toggles" do
      FeaturesRepository.create_feature "queue", ""
      FeaturesRepository.create_feature "vatu", ""
      (File.exist? Settings.toggles_repo_path + "/qa.json").should == false
      EnvironmentsRepository.create_environment "qa"
      (File.exist? Settings.toggles_repo_path + "/qa.json").should == true
      toggles = FileIO.load_create_json Settings.toggles_repo_path + "/qa.json"
      toggles['queue'].should == false
      toggles['vatu'].should == false
    end
  end
end