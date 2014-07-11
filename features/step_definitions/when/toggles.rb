When(/^I click the toggle button for "([^"]*)"$/) do |feature|
  find(:css, "##{feature.downcase.split.join("_")} .toggle-button").click
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