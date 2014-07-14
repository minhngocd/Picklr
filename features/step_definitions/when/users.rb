And(/^I login as "([^"]*)"$/) do |email|
  visit "/"
  find(:css, "a", text: "Login").click
  fill_in :user_email, with: email
  fill_in :user_password, with: Constants.some_password
  find("input[value='Sign in']").click
end