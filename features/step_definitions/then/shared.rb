
Then(/^I should not see "([^"]*)"$/) do |text|
  page.text.should_not include text
end

Then(/^I should see "([^"]*)"$/) do |text|
  page.text.should include text
end

Then(/^I should see notice "([^"]*)"$/) do |notice|
  find(:css, ".alert").text.should include notice
end

Then(/^I should see error "([^"]*)"$/) do |error|
  find(:css, ".alert-danger").text.should include error
end