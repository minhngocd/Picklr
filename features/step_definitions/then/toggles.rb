Then(/^I should be taken to the toggles page for the "([^"]*)" environment$/) do |environment|
  current_path.should == "/features/#{environment}"
end

Then(/^I should see the toggle "([^"]*)" is turned "([^"]*)"$/) do |toggle_name, switch|
  find(:css, "##{toggle_name.downcase.split.join("_")} .switch")["class"].should include switch
end