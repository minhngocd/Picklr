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
  end


  RSpec::Matchers.define :contain_toggle do |expected_toggle|
    match do |actual_list|
      actual_list.each do |listed_toggle|
        puts "expected toggle ",expected_toggle.inspect, " listed toggle ", listed_toggle.inspect
        if (listed_toggle.name == expected_toggle.name \
        && listed_toggle.display_name == expected_toggle.display_name \
        && listed_toggle.description == expected_toggle.description) then
          return true
        end
      end
      return false
    end
  end

end