class FeaturesRepository

  def self.all_features
    all_features = FileIO.load_create_json Settings.features_repo_file
    all_features.map { |feature| feature['name'] }
  end

  def self.create_feature name, description
    FileIO.append_create_json({name: name, description: description}, Settings.features_repo_file)

    EnvironmentsRepository.all_environments.each do |environment|
      if (!File.exist?(Settings.toggles_repo_path + "/#{environment}.json"))
        TogglesRepository.create environment
      else
        FileIO.merge_create_json({name => false}, Settings.toggles_repo_path + "/#{environment}.json")
      end
    end
  end

  def self.feature_exists? name
    self.all_features.include? name
  end

end
