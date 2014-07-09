When(/^I visit the features page$/) do
  visit "/features"
end


When(/^I visit the toggles page for environment "([^"]*)"$/) do |environment|
  visit "/features/#{environment}"
end