class FeaturesRepository < ActiveRecord::Base

  def self.all_features
    self.all.map{|feature| feature.name}
  end

end
