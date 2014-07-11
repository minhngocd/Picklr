Then(/^I should see the feature "([^"]*)" is toggled "([^"]*)"$/) do |feature, toggle|
  find(:css, "##{feature.downcase.split.join("_")} .toggle")["class"].should include toggle
end

Then(/^I should not see the toggle button for "([^"]*)"$/) do |feature|
  page.should have_no_selector(:css, "##{feature.downcase.split.join("_")} .toggle-button")
end

Then(/^I should see the toggle button for "([^"]*)"$/) do |feature|
  find(:css, "##{feature.downcase.split.join("_")} .toggle-button").should be_visible
end

Then(/^I should not see the add feature button$/) do
  page.should have_no_selector("input[value='Add new feature']")
end

Then(/^I should see the add feature button$/) do
  find("input[value='Add new feature']").should be_visible
end

Then(/^I should see a "([^"]*)" checkbox for "([^"]*)"$/) do |checked_status, environment|
  checked = (checked_status == "checked")
  my_box = find(:css, "##{environment} input[type='checkbox']")
  if checked
    my_box.should be_checked
  else
    my_box.should_not be_checked
  end
end