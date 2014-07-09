class TogglesValue < ActiveRecord::Base

  def self.toggles_for_environment environment
    TogglesRepository.all.map do |toggle_info|
      environment_toggle = TogglesValue.find_by(environment_name: environment, toggle_name: toggle_info.name)
      toggle_value = environment_toggle.value unless environment_toggle.nil?
      Toggle.new(toggle_info.name,
                 toggle_info.display_name,
                 toggle_value,
                 environment,
                 toggle_info.description)
    end
  end

end
