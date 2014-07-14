
Given(/^I have feature "([^"]*)" toggled "([^"]*)" for environment "([^"]*)"$/) do |feature, toggle, environment|
  underscore_feature_name = feature.downcase.split.join("_")
  FeaturesRepository.create! name: underscore_feature_name
  TogglesRepository.create! feature_name: underscore_feature_name, environment_name: environment, value: toggle == "on" ? true : false
end
