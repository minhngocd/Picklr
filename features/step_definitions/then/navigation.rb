Then(/^I should be taken to the feature toggles page for the "([^"]*)" environment$/) do |environment|
  current_path.should == "/features/#{environment}"
end

Then(/^I should be taken to the base features page$/) do
  current_path.should == "/"
end