class TogglesRepository < ActiveRecord::Base

  def self.all_for environment
    return nil unless EnvironmentsRepository.find_by_name environment
    FeaturesRepository.all.map do |feature|
      db_toggle = TogglesRepository.find_by(environment_name: environment, feature_name: feature.name)
      Toggle.new(ApplicationFeature.new(feature.name, feature.description),
                 Environment.new(environment),
                 db_toggle.nil? ? false : db_toggle.next_value)
    end
  end

  def self.value_for environment, feature
    return nil unless EnvironmentsRepository.find_by_name(environment) && FeaturesRepository.find_by_name(feature)

    db_toggle = self.find_by environment_name: environment, feature_name: feature
    db_toggle.nil? ? false : db_toggle.next_value
  end

  def self.toggle environment, feature
    raise Exception.new "Make sure environment and feature exists!" unless EnvironmentsRepository.find_by_name(environment) && FeaturesRepository.find_by_name(feature)

    db_toggle = self.find_or_create_by! environment_name: environment, feature_name: feature
    db_toggle.update_attributes!(next_value: !db_toggle.next_value)
  end

  def self.toggle_with_value environment, feature, value
    raise Exception.new "Make sure environment and feature exists!" unless EnvironmentsRepository.find_by_name(environment) && FeaturesRepository.find_by_name(feature)

    db_toggle = self.find_or_create_by! environment_name: environment, feature_name: feature
    db_toggle.update_attributes!(next_value: value)
  end
end
