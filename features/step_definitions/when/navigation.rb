When(/^I visit the features page$/) do
  visit "/features"
end


When(/^I visit the toggles page for environment "([^"]*)"$/) do |environment|
  visit "/features/#{environment}"
end

When(/^I request the toggles json for environment "([^"]*)"$/) do |environment|
  visit "/features/#{environment}.json"
end