
When(/^I click the environment "([^"]*)"$/) do |environment|
  find(:css, "#environment-list a", text: environment).click
end