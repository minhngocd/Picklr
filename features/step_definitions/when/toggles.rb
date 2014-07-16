When(/^I click the toggle button for "([^"]*)"$/) do |feature|
  find(:css, "##{feature.downcase.split.join("_")} .button").click
end

When(/^I click the complete feature edit button$/) do
  find("input[value='Complete']").click
end

When(/^I uncheck the checkbox for "([^"]*)"$/) do |environment|
  find(:css, "##{environment} input[type='checkbox']").set(false)
end

When(/^I check the checkbox for "([^"]*)"$/) do |environment|
  find(:css, "##{environment} input[type='checkbox']").set(true)
end

And(/^I click the add feature button$/) do
  find("a", text: "Add new feature").click
end

When(/^I click the create new feature button$/) do
  find("input[value='Create new feature']").click
end

When(/^I fill out field "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field.downcase.split.join("_"), with: value
end