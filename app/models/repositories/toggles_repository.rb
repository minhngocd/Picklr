class TogglesRepository

  def self.all_for environment
    return nil unless EnvironmentsRepository.environment_exists? environment
    all_toggles = FileIO.load_create_json Settings.toggles_repo_path + "/#{environment}.json"
    if (all_toggles.empty?)
      self.create environment
      all_toggles = FileIO.load_create_json Settings.toggles_repo_path + "/#{environment}.json"
    end
    all_toggles
  end

  def self.create environment
    return nil unless EnvironmentsRepository.environment_exists? environment
    toggles = {}
    FeaturesRepository.all_features.each do |feature|
      toggles.merge!(feature => false)
    end
    FileIO.write_create_json(toggles, Settings.toggles_repo_path + "/#{environment}.json")
  end

  def self.value_for environment, feature
    return nil unless
        EnvironmentsRepository.environment_exists?(environment) &&
            FeaturesRepository.feature_exists?(feature)

    self.all_for(environment)[feature]
  end

  def self.toggle environment, feature
    raise Exception.new "Make sure environment and feature exists!" unless
        EnvironmentsRepository.environment_exists?(environment) &&
            FeaturesRepository.feature_exists?(feature)

    new_value = !self.value_for(environment, feature)
    self.toggle_with_value(environment, feature, new_value)
  end

  def self.toggle_with_value environment, feature, value
    raise Exception.new "Make sure environment and feature exists!" unless
        EnvironmentsRepository.environment_exists?(environment) &&
            FeaturesRepository.feature_exists?(feature)

    FileIO.merge_create_json({feature => value},  Settings.toggles_repo_path + "/#{environment}.json")
  end
end
