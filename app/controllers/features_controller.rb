class FeaturesController < ApplicationController
  before_filter :authenticate_user!, only: [:toggle, :edit_feature, :update_feature]

  def all
    @environments = EnvironmentsRepository.all_environments
  end

  def show
    @environment = params[:env]
    @toggles = TogglesRepository.all_for @environment
    return render text: "Environment does not exist", status: 404 if @toggles.nil?

    respond_to do |format|
      format.html
      format.json { render json: @toggles.inject({}) { |result, toggle| result.merge({toggle.name => toggle.value}) } }
    end
  end

  def show_toggle
    toggle = TogglesRepository.value_for(params[:env], params[:feature])
    return render text: "Environment or Feature does not exist", status: 404 if toggle.nil?

    render json: {params[:feature] => toggle}
  end

  def toggle
    begin
      TogglesRepository.toggle(params[:env], params[:feature])
      redirect_to action: :show, status: 302
    rescue Exception => exception
      render text: exception.message, status: 500
    end
  end

  def edit_feature
    all_environments = EnvironmentsRepository.all_environments
    @environment_toggle_values = all_environments.inject({}) do |result, environment|
      toggle_value = TogglesRepository.value_for environment, params[:feature]
      return render text: "Feature does not exist", status: 404 if toggle_value.nil?
      result.merge({environment => toggle_value})
    end
  end

  def update_feature
    begin
      EnvironmentsRepository.all_environments.each do |environment|
        toggle_value = params[:environments].include? environment
        TogglesRepository.toggle_with_value(environment, params[:feature], toggle_value)
      end
      flash[:notice] = "Feature updated"
      redirect_to action: :all, status: 302
    rescue Exception => exception
      render text: exception.message, status: 500
    end
  end
end