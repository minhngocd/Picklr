Then(/^I should be taken to the feature toggles page for the "([^"]*)" environment$/) do |environment|
  current_path.should == "/environments/#{environment}"
end

Then(/^I should be taken to the base features page$/) do
  current_path.should == "/"
end

Then(/^I should be taken to the add new feature page$/) do
  current_path.should == "/feature/new"
end

Then(/^I should be taken to the edit toggle values page for feature "([^"]*)"$/) do |feature|
  current_path.should == "/feature/edit/#{feature}"
end