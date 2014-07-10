require 'spec_helper'

describe TogglesRepository do


  before do
    FeaturesRepository.create!(name: "queue", display_name: "Queue", description: "description")
    FeaturesRepository.create!(name: "vatu", display_name: "VATU", description: "description")
    TogglesRepository.create!(feature_name: "queue", environment_name: "qa"  , value: true)
    TogglesRepository.create!(feature_name: "vatu", environment_name: "qa"  , value: false)
    TogglesRepository.create!(feature_name: "queue", environment_name: "uat" , value: true)
    TogglesRepository.create!(feature_name: "queue", environment_name: "prod", value: true)
  end

  it "should return all toggles for a given environment" do
    all_qa_toggles = TogglesRepository.all_for "qa"
    all_qa_toggles.length.should == 2
    (all_qa_toggles.first.is_a? Toggle).should == true
    all_qa_toggles.should contain_toggle Toggle.new "queue", "Queue", true, "qa", "description"
    all_qa_toggles.should contain_toggle Toggle.new "vatu", "VATU", false, "qa", "description"
  end

  it "should return toggles that are not set for an environment with nil value" do
    all_uat_toggles = TogglesRepository.all_for "uat"
    all_uat_toggles.length.should == 2
    (all_uat_toggles.first.is_a? Toggle).should == true
    all_uat_toggles.should contain_toggle Toggle.new "queue", "Queue", true, "uat", "description"
    all_uat_toggles.should contain_toggle Toggle.new "vatu", "VATU", nil, "uat", "description"
  end

  it "should return toggle value given toggle name and environment" do
    TogglesRepository.value_for(environment: "qa", feature: "queue").should == true
    TogglesRepository.value_for(environment: "qa", feature: "vatu").should == false
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
      listed_toggle.name == expected_toggle.name &&
          listed_toggle.display_name == expected_toggle.display_name &&
          listed_toggle.description == expected_toggle.description &&
          listed_toggle.environment == expected_toggle.environment &&
          listed_toggle.value == expected_toggle.value
    end
  end

end
