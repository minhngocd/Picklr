class EnvironmentsRepository < ActiveRecord::Base

  def self.all_environments
    self.all.map{|environment| environment.name}
  end

  def self.create_environment name
    self.create! name: name
  end
end
