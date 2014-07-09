class EnvironmentsController < ActionController::Base

  def all
    @environments = EnvironmentsRepository.all_environments
  end

  def show
    @toggles = TogglesValue.toggles_for_environment params[:env]
  end

end