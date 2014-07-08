class EnvironmentsRepository < ActiveRecord::Base

  def self.all_environments
    all_environments = []
    self.all.each do |db_environment|
      all_environments << Environment.new(db_environment.name)
    end
    all_environments
  end

end
