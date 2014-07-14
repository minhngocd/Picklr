class FeaturesRepository < ActiveRecord::Base

  def self.all_features
    self.all.map{|feature| feature.name}
  end

  def self.create_feature name, display_name, description
    self.create!(name: name, display_name: display_name, description: description)
  end

end
