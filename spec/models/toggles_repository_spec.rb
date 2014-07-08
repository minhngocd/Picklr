require 'spec_helper'

describe TogglesRepository do

  before do
    TogglesRepository.create!(name: "test1", display_name: "Test 1", description: "description")
    TogglesRepository.create!(name: "test2", display_name: "Test 2", description: "description")
    TogglesRepository.create!(name: "test3", display_name: "Test 3", description: "description")
  end

  it "should find all toggles" do
    all_toggles = TogglesRepository.all_toggles
    all_toggles.length.should eq 3
    (all_toggles.first.is_a? Toggle).should be true
    all_toggles.should contain_toggle Toggle.new("test1", "Test 1", "description")
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
          listed_toggle.description == expected_toggle.description
    end
  end

end