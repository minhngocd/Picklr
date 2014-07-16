
Given(/^I have feature "([^"]*)" toggled "([^"]*)" for environment "([^"]*)"$/) do |feature, toggle, environment|
  underscore_feature_name = feature.downcase.split.join("_")
  FeaturesRepository.create_feature underscore_feature_name, ""
  TogglesRepository.toggle_with_value environment, underscore_feature_name, toggle == "on" ? true : false
end
