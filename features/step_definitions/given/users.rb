Given(/^I have admin "([^"]*)"$/) do |email|
  User.create! email: email, password: Constants.some_password, password_confirmation: Constants.some_password, admin: true
end

Given(/^I am logged out$/) do
  visit 'users/sign_out'
end