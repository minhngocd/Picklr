class EnvironmentsController < ActionController::Base

  def all
    @environments = EnvironmentsRepository.all_environments
  end

  def show
    @toggles = TogglesValue.toggles_for_environment params[:env]
    respond_to do |format|
      format.html
      format.json { render json: @toggles.inject({}) { |result, toggle| result.merge({toggle.name => toggle.value}) } }
    end
  end
end