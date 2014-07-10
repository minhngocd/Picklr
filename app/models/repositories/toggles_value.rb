class TogglesValue < ActiveRecord::Base

  def self.toggles_for_environment environment
    FeaturesRepository.all.map do |feature|
      toggle = TogglesValue.find_by(environment_name: environment, feature_name: feature.name)
      toggle_value = toggle.value unless toggle.nil?
      Toggle.new(feature.name,
                 feature.display_name,
                 toggle_value,
                 environment,
                 feature.description)
    end
  end

  def self.toggle_value params
    toggle = self.find_by environment_name: params[:environment], feature_name: params[:feature]
    return nil if toggle.nil?
    toggle.value
  end

end
