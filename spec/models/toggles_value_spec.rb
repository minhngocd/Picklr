require 'spec_helper'

describe TogglesValue do


  before do
    TogglesRepository.create!(name: "queue", display_name: "Queue", description: "description")
    TogglesRepository.create!(name: "vatu", display_name: "VATU", description: "description")
    TogglesValue.create!(toggle_name: "queue", environment_name: "qa"  , value: true)
    TogglesValue.create!(toggle_name: "vatu", environment_name: "qa"  , value: false)
    TogglesValue.create!(toggle_name: "queue", environment_name: "uat" , value: true)
    TogglesValue.create!(toggle_name: "queue", environment_name: "prod", value: true)
  end

  it "should return all toggles for a given environment" do
    all_qa_toggles = TogglesValue.toggles_for_environment "qa"
    all_qa_toggles.length.should == 2
    (all_qa_toggles.first.is_a? Toggle).should == true
    all_qa_toggles.should contain_toggle Toggle.new "queue", "Queue", true, "qa", "description"
    all_qa_toggles.should contain_toggle Toggle.new "vatu", "VATU", false, "qa", "description"
  end

  it "should return toggles that are not set for an environment with nil value" do
    all_uat_toggles = TogglesValue.toggles_for_environment "uat"
    all_uat_toggles.length.should == 2
    (all_uat_toggles.first.is_a? Toggle).should == true
    all_uat_toggles.should contain_toggle Toggle.new "queue", "Queue", true, "uat", "description"
    all_uat_toggles.should contain_toggle Toggle.new "vatu", "VATU", nil, "uat", "description"
  end

  it "should return toggle value given toggle name and environment" do
    TogglesValue.toggle_value(environment: "qa", toggle: "queue").should == true
    TogglesValue.toggle_value(environment: "qa", toggle: "vatu").should == false
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
