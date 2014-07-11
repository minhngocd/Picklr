
Then(/^I should not see "([^"]*)"$/) do |text|
  page.text.should_not include text
end

Then(/^I should see "([^"]*)"$/) do |text|
  page.text.should include text
end

And(/^I should see notice "([^"]*)"$/) do |notice|
  find(:css, ".alert").text.should include notice
end