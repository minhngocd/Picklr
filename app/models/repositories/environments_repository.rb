class EnvironmentsRepository < ActiveRecord::Base

  def self.all_environments
    self.all.map{|environment| Environment.new environment.name}
  end

end
