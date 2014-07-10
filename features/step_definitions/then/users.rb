Then(/^I should see the login link$/) do
  find(:css, "a", text: "Login").should be_visible
end

Then(/^I should not see the logout link$/) do
  page.should have_no_selector(:css, "a", text: "Logout")
end


And(/^I should see the logout link$/) do
  find(:css, "a", text: "Logout").should be_visible
end

And(/^I should not see the login link$/) do
  page.should have_no_selector(:css, "a", text: "Login")
end