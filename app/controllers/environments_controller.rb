class EnvironmentsController < ApplicationController
  before_filter :authenticate_user!, except: [:all]

  def all
    @environments = EnvironmentsRepository.all_environments
  end
end