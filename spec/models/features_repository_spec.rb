require 'spec_helper'

describe FeaturesRepository do

  before do
    FeaturesRepository.create!(name: "test1", display_name: "Test 1", description: "description")
    FeaturesRepository.create!(name: "test2", display_name: "Test 2", description: "description")
    FeaturesRepository.create!(name: "test3", display_name: "Test 3", description: "description")
  end

  it "should find all toggles" do
    all_toggles = FeaturesRepository.all_features
    all_toggles.length.should == 3
    all_toggles.should include "test1"
    all_toggles.should include "test2"
    all_toggles.should include "test3"
  end

end