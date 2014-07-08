class TogglesRepository < ActiveRecord::Base

  def self.all_toggles
    all_toggles = []
    self.all.each do |db_toggle|
      all_toggles << Toggle.new(db_toggle.name, db_toggle.display_name, db_toggle.description)
    end
    all_toggles
  end

end
