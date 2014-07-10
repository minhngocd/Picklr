class EnvironmentsRepository < ActiveRecord::Base

  def self.all_environments
    self.all.map{|environment| environment.name}
  end

end
