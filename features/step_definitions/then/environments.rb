Then(/^I should see environment "([^"]*)"$/) do |environment|
  find(:id, "environment-list").should have_content environment
end


Then(/^I should not see the add environment button$/) do
  page.should have_no_selector("a", text: 'Add new environment')
end

Then(/^I should see the add environment button$/) do
  find("a", text: 'Add new environment').should be_visible
end