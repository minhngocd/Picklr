When(/^I visit the base page$/) do
  visit "/"
end


When(/^I visit the feature toggles page for environment "([^"]*)"$/) do |environment|
  visit "/environments/#{environment}"
end

When(/^I request json for all feature toggles on environment "([^"]*)"$/) do |environment|
  visit "/environments/#{environment}.json"
end

When(/^I request json for feature "([^"]*)" on environment "([^"]*)"$/) do |feature, environment|
  visit "/environments/#{environment}/#{feature}.json"
end

When(/^I visit the edit toggle values page for feature "([^"]*)"$/) do |feature|
  visit "/feature/edit/#{feature}"
end