class FeaturesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    all_environments = EnvironmentsRepository.all_environments
    @environment_toggle_values = all_environments.inject({}) do |result, environment|
      toggle_value = TogglesRepository.value_for environment, params[:feature]
      return render text: "Feature does not exist", status: 404 if toggle_value.nil?
      result.merge({environment => toggle_value})
    end
  end

  def update
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

  def create
    begin
      feature = ApplicationFeature.new(params[:name], params[:description])

      if feature.valid?
        FeaturesRepository.create_feature(feature.name, feature.description)

        flash[:notice] = "Feature created!"
        redirect_to action: :edit, status: 302, feature: params[:name]
      else
        flash[:alert] = feature.errors.full_messages
        redirect_to action: :new
      end
    rescue Exception => exception
      render text: exception.message, status: 500
    end
  end
end