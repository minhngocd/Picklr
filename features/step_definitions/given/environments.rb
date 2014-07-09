Given(/^I have environment "([^"]*)"$/) do |environment|
  EnvironmentsRepository.create!(name: environment)
end