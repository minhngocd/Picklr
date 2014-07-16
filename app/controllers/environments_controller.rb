class EnvironmentsController < ApplicationController
  before_filter :authenticate_user!, except: [:all]

  def all
    @environments = EnvironmentsRepository.all_environments
  end

  def create
    begin
      environment = Environment.new params[:name]

      if environment.valid?
        EnvironmentsRepository.create_environment(environment.name)

        flash[:notice] = "Environment created!"
        redirect_to controller: :toggles, action: :all, status: 302, env: environment.name
      else
        flash[:alert] = environment.errors.full_messages.to_sentence
        redirect_to action: :new
      end
    rescue Exception => exception
      render text: exception.message, status: 500
    end
  end
end