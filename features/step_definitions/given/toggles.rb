
Given(/^I have toggle "([^"]*)" turned "([^"]*)" for environment "([^"]*)"$/) do |toggle_name, switch, environment|
  underscore_toggle_name = toggle_name.downcase.split.join("_")
  TogglesRepository.create! name: underscore_toggle_name, display_name: toggle_name
  TogglesValue.create! toggle_name: underscore_toggle_name, environment_name: environment, value: switch == "on" ? true : false
end
