When(/^I click the environment "([^"]*)"$/) do |environment|
  find(:css, "#environment-list a", text: environment).click
end


And(/^I click the add environment button$/) do
  find("a", text: 'Add new environment').click
end

When(/^I click the create new environment button$/) do
  find("input[value='Create new environment']").click
end