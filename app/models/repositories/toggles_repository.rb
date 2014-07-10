class TogglesRepository < ActiveRecord::Base

  def self.all_for environment
    return nil unless EnvironmentsRepository.find_by_name environment
    FeaturesRepository.all.map do |feature|
      toggle = TogglesRepository.find_by(environment_name: environment, feature_name: feature.name)
      Toggle.new(feature.name,
                 feature.display_name,
                 toggle.nil? ? false : toggle.value,
                 environment,
                 feature.description)
    end
  end

  def self.value_for environment, feature
    return nil unless EnvironmentsRepository.find_by_name(environment) && FeaturesRepository.find_by_name(feature)

    toggle = self.find_by environment_name: environment, feature_name: feature
    toggle.nil? ? false : toggle.value
  end

  def self.toggle environment, feature
    raise Exception.new "Make sure environment and feature exists!" unless EnvironmentsRepository.find_by_name(environment) && FeaturesRepository.find_by_name(feature)

    toggle = self.find_or_create_by! environment_name: environment, feature_name: feature
    toggle.update_attributes!(value: !toggle.value)
  end
end
