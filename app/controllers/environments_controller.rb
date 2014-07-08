class EnvironmentsController < ActionController::Base

  def all
    @environments = EnvironmentsRepository.all_environments || []
  end

end