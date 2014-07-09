When(/^I visit the features page$/) do
  visit "/features"
end


When(/^I visit the toggles page for environment "([^"]*)"$/) do |environment|
  visit "/features/#{environment}"
end

When(/^I request json for all toggles on environment "([^"]*)"$/) do |environment|
  visit "/features/#{environment}.json"
end

When(/^I request json for toggle "([^"]*)" on environment "([^"]*)"$/) do |toggle, environment|
  visit "/features/#{environment}/#{toggle}.json"
end