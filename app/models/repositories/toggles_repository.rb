class TogglesRepository < ActiveRecord::Base

  def self.all_toggles
    self.all.map{|toggle_info| toggle_info.name}
  end

end
