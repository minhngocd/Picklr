Then(/^I should see environment "([^"]*)"$/) do |environment|
  find(:id, "environment-list").should have_content environment
end
