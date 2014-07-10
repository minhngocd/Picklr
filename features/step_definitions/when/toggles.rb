And(/^I click the toggle button for "([^"]*)"$/) do |feature|
  find(:css, "##{feature.downcase.split.join("_")} .toggle-button").click
end