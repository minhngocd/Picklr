Given(/^I have environment "([^"]*)"$/) do |environment|
  EnvironmentsRepository.create_environment environment
end