require 'spec_helper'

describe EnvironmentsRepository do

  before do
    EnvironmentsRepository.create!(name: "qa")
    EnvironmentsRepository.create!(name: "uat")
    EnvironmentsRepository.create!(name: "prod")
  end

  it "should find all environments" do
    all_environments = EnvironmentsRepository.all_environments
    all_environments.length.should == 3
    (all_environments.first.is_a? Environment).should == true
    all_environments.should contain_environment Environment.new("qa")
    all_environments.should contain_environment Environment.new("uat")
    all_environments.should contain_environment Environment.new("prod")
  end

  RSpec::Matchers.define :contain_environment do |expected_environment|
    result = false
    match do |actual_list|
      actual_list.each do |listed_environment|
        if (listed_environment.name == expected_environment.name)
          result = true
          break
        end
      end
    result
    end

  end

end