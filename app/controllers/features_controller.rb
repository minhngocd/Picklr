class FeaturesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit_feature, :update_feature, :create_feature]

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
      redirect_to controller: :environments, action: :all, status: 302
    rescue Exception => exception
      render text: exception.message, status: 500
    end
  end

  def create_feature
    begin
      feature = ApplicationFeature.new(params[:name], params[:display_name], params[:description])

      if feature.valid?
        FeaturesRepository.create_feature(feature.name, feature.display_name, feature.description)

        flash[:notice] = "Feature created!"
        redirect_to action: :edit_feature, status: 302, feature: params[:name]
      else
        flash[:alert] = feature.errors.full_messages
        redirect_to action: :new_feature
      end
    rescue Exception => exception
      render text: exception.message, status: 500
    end
  end

  def new_feature
  end
end