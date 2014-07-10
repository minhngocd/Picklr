class FeaturesController < ActionController::Base

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

  def show_toggle
    render json: {params[:feature] => TogglesValue.toggle_value(environment: params[:env], feature: params[:feature])}
  end
end