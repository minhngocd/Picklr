require 'spec_helper'

describe TogglesRepository do

  let(:qa) { Environment.new "qa" }
  let(:uat) { Environment.new "uat" }
  let(:queue) { ApplicationFeature.new "queue", "description" }
  let(:vatu) { ApplicationFeature.new "vatu", "description" }
  before do
    EnvironmentsRepository.create!(name: "qa")
    EnvironmentsRepository.create!(name: "uat")
    FeaturesRepository.create!(name: "queue", description: "description")
    FeaturesRepository.create!(name: "vatu", description: "description")
    TogglesRepository.create!(feature_name: "queue", environment_name: "qa", next_value: true)
    TogglesRepository.create!(feature_name: "vatu", environment_name: "qa", next_value: false)
    TogglesRepository.create!(feature_name: "queue", environment_name: "uat", next_value: true)
    TogglesRepository.create!(feature_name: "queue", environment_name: "prod", next_value: true)
  end

  describe "all toggles" do
    it "should return all toggles for a given environment" do
      all_qa_toggles = TogglesRepository.all_for "qa"
      all_qa_toggles.length.should == 2
      (all_qa_toggles.first.is_a? Toggle).should == true
      all_qa_toggles.should contain_toggle Toggle.new queue, qa, true
      all_qa_toggles.should contain_toggle Toggle.new vatu, qa, false
    end

    it "should return default false value for toggles not set for environment" do
      all_uat_toggles = TogglesRepository.all_for "uat"
      all_uat_toggles.length.should == 2
      (all_uat_toggles.first.is_a? Toggle).should == true
      all_uat_toggles.should contain_toggle Toggle.new queue, uat, true
      all_uat_toggles.should contain_toggle Toggle.new vatu, uat, false
    end

    it "should return nil if environment doesn't exist" do
      TogglesRepository.all_for("prod").should == nil
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

    it "should return false if feature is not set for environment" do
      TogglesRepository.value_for("uat", "vatu").should == false
    end
  end

  describe "toggle value" do
    it "should toggle the value of a feature toggle" do
      TogglesRepository.toggle("qa","queue")
      TogglesRepository.value_for("qa","queue").should == false
      TogglesRepository.toggle("qa","vatu")
      TogglesRepository.value_for("qa","vatu").should == true
    end

    it "should create the toggle value and set to true if not already set" do
      TogglesRepository.toggle("uat","vatu")
      TogglesRepository.value_for("uat", "vatu").should == true
    end

    it "should raise exception if environment doesn't exist" do
      lambda{TogglesRepository.toggle("qa", "some_feature")}.should raise_exception
    end

    it "should raise exception if feature doesn't exist" do
      lambda{TogglesRepository.toggle("prod", "queue")}.should raise_exception
    end
  end

  describe "toggle with given value" do
    it "should toggle the value of a feature toggle" do
      TogglesRepository.toggle_with_value("qa","queue", false)
      TogglesRepository.value_for("qa","queue").should == false
      TogglesRepository.toggle_with_value("qa","vatu", true)
      TogglesRepository.value_for("qa","vatu").should == true
    end

    it "should create the toggle value if not already set" do
      TogglesRepository.toggle_with_value("uat","vatu", true)
      TogglesRepository.value_for("uat", "vatu").should == true
    end

    it "should raise exception if environment doesn't exist" do
      lambda{TogglesRepository.toggle_with_value("qa", "some_feature", true)}.should raise_exception
    end

    it "should raise exception if feature doesn't exist" do
      lambda{TogglesRepository.toggle_with_value("prod", "queue", true)}.should raise_exception
    end
  end

  RSpec::Matchers.define :contain_toggle do |expected_toggle|
    result = false
    match do |actual_list|
      actual_list.each do |listed_toggle|
        if toggle_match?(expected_toggle, listed_toggle)
          result = true
          break
        end
      end
      result
    end

    def toggle_match?(expected_toggle, listed_toggle)
      listed_toggle.feature.name == expected_toggle.feature.name &&
          listed_toggle.feature.description == expected_toggle.feature.description &&
          listed_toggle.environment.name == expected_toggle.environment.name &&
          listed_toggle.value == expected_toggle.value
    end
  end

end
