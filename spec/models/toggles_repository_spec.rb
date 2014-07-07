require 'spec_helper'

describe TogglesRepository do

  before do
    TogglesRepository.create!(name: "test1", display_name: "Test 1", description: "description")
    TogglesRepository.create!(name: "test2", display_name: "Test 2", description: "description")
    TogglesRepository.create!(name: "test3", display_name: "Test 3", description: "description")
  end

  it "should find all toggles" do
    all_toggles = TogglesRepository.all_toggles
    expect(all_toggles.length).should == 3
  end

end