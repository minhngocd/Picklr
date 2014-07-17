class EnvironmentsRepository

  def self.all_environments
    all_environments = FileIO.load_create_json Settings.environments_repo_file
    all_environments.map{|environment| environment['name']}
  end

  def self.create_environment name
    FileIO.append_create_json({name: name}, Settings.environments_repo_file)
    if(!File.exist?(Settings.toggles_repo_path + "/#{name}.json"))
      TogglesRepository.create name
    end
  end

  def self.environment_exists? name
    self.all_environments.include? name
  end
end
