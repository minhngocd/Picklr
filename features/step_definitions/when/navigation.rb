When(/^I visit the base page$/) do
  visit "/features"
end


When(/^I visit the feature toggles page for environment "([^"]*)"$/) do |environment|
  visit "/features/#{environment}"
end

When(/^I request json for all feature toggles on environment "([^"]*)"$/) do |environment|
  visit "/features/#{environment}.json"
end

When(/^I request json for feature "([^"]*)" on environment "([^"]*)"$/) do |feature, environment|
  visit "/features/#{environment}/#{feature}.json"
end