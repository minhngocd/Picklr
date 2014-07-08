
Given(/^I have environment "([^"]*)"$/) do |environment|
  EnvironmentsRepository.create!(name: environment)
end

Then(/^I should see environment "([^"]*)"$/) do |environment|
  find(:id, "environment-list").should have_content environment
end