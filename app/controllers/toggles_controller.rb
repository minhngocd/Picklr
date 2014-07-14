class TogglesController < ApplicationController
  before_filter :authenticate_user!, except: [:all, :show]

  def all
    @environment = params[:env]
    @toggles = TogglesRepository.all_for @environment
    return render text: "Environment does not exist", status: 404 if @toggles.nil?

    respond_to do |format|
      format.html
      format.json { render json: @toggles.inject({}) { |result, toggle| result.merge({toggle.name => toggle.value}) } }
    end
  end

  def show
    toggle = TogglesRepository.value_for(params[:env], params[:feature])
    return render text: "Environment or Feature does not exist", status: 404 if toggle.nil?

    render json: {params[:feature] => toggle}
  end

  def toggle
    begin
      TogglesRepository.toggle(params[:env], params[:feature])
      redirect_to action: :all, status: 302
    rescue Exception => exception
      render text: exception.message, status: 500
    end
  end
end