class FeaturesRepository < ActiveRecord::Base

  def self.all_features
    self.all.map{|feature| feature.name}
  end

  def self.create_feature name, description
    self.create!(name: name, description: description)
  end

  def self.feature_exists? name
    self.exists? name: name
  end

end
