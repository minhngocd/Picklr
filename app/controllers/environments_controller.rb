class EnvironmentsController < ApplicationController
  def all
    @environments = EnvironmentsRepository.all_environments
  end
end