require 'spec_helper'

describe TogglesRepository do

  before do
    FileIO.write_create_json([{name: "qa"},{name: "uat"}], Settings.environments_repo_file)
    FileIO.write_create_json([{name: "queue", description: ""},{name: "vatu", description: ""}], Settings.features_repo_file)

    qa_toggles = {queue: true, vatu: false}
    uat_toggles = {queue: true, vatu: false}
    FileIO.write_create_json(qa_toggles, Settings.toggles_repo_path + "/qa.json")
    FileIO.write_create_json(uat_toggles, Settings.toggles_repo_path + "/uat.json")
  end

  describe "all toggles" do
    it "should return all toggles for a given environment" do
      qa_toggles = TogglesRepository.all_for "qa"
      qa_toggles.length.should == 2
      qa_toggles["queue"].should == true
      qa_toggles["vatu"].should == false
    end

    it "should return nil if environment doesn't exist" do
      TogglesRepository.all_for("prod").should == nil
    end

    it "should create file with default feature toggles if environment exists but toggle file doesn't exist" do
      EnvironmentsRepository.create_environment "prod"
      prod_toggles = TogglesRepository.all_for("prod")
      prod_toggles.length.should == 2
      prod_toggles["queue"].should == false
      prod_toggles["vatu"].should == false
    end
  end

  describe "single toggle value" do
    it "should return toggle value given toggle name and environment" do
      TogglesRepository.value_for("qa", "queue").should == true
      TogglesRepository.value_for("qa", "vatu").should == false
    end

    it "should return nil if environment doesn't exist" do
      TogglesRepository.value_for("prod", "queue").should == nil
    end

    it "should return nil if feature doesn't exist" do
      TogglesRepository.value_for("qa", "some_feature").should == nil
    end

    it "should create file with default feature toggles if environment exists but toggle file doesn't exist" do
      EnvironmentsRepository.create_environment "prod"
      prod_toggles = TogglesRepository.value_for("prod","queue")
      prod_toggles.should == false
      TogglesRepository.all_for("prod").length.should == 2
    end
  end

  describe "toggle value" do
    it "should toggle the value of a feature toggle" do
      TogglesRepository.toggle("qa", "queue")
      TogglesRepository.value_for("qa", "queue").should == false
      TogglesRepository.toggle("qa", "vatu")
      TogglesRepository.value_for("qa", "vatu").should == true
    end

    it "should raise exception if entry not found" do
      lambda { TogglesRepository.toggle("qa", "something") }.should raise_exception
    end
  end

  describe "toggle with given value" do
    it "should toggle the value of a feature toggle" do
      TogglesRepository.toggle_with_value("qa", "queue", false)
      TogglesRepository.value_for("qa", "queue").should == false
      TogglesRepository.toggle_with_value("qa", "vatu", true)
      TogglesRepository.value_for("qa", "vatu").should == true
    end

    it "should raise exception if entry not found" do
      lambda { TogglesRepository.toggle_with_value("qa", "something", true) }.should raise_exception
    end
  end

end
