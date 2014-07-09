class TogglesValue < ActiveRecord::Base

  def self.toggles_for_environment environment
    self.where(environment_name: environment).map do |toggle_value|
      toggle_info = TogglesRepository.find_by_name toggle_value.toggle_name
      Toggle.new(toggle_info.name,
                 toggle_info.display_name,
                 toggle_value.value,
                 toggle_value.environment_name,
                 toggle_info.description)
    end
  end

end
