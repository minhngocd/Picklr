Then(/^I should be taken to the feature toggles page for the "([^"]*)" environment$/) do |environment|
  current_path.should == "/features/#{environment}"
end

Then(/^I should see the feature "([^"]*)" is toggled "([^"]*)"$/) do |feature, toggle|
  find(:css, "##{feature.downcase.split.join("_")} .toggle")["class"].should include toggle
end

Then(/^I should not see the toggle button for "([^"]*)"$/) do |feature|
  page.should have_no_selector(:css, "##{feature.downcase.split.join("_")} .toggle-button")
end

Then(/^I should see the toggle button for "([^"]*)"$/) do |feature|
  find(:css, "##{feature.downcase.split.join("_")} .toggle-button").should be_visible
end