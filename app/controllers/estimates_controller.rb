class EstimatesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @estimate = Estimate.new(estimate_params)
    if @estimate.save
      render :show, status: :ok
    else
      render :show, status: :not_acceptable
    end
  end

  def show
    @estimate = Estimate.find(params[:id])
  end

  def estimate_params
    params.require(:estimate).permit(
      :origin_latitude, :origin_longitude, :destination_latitude, :destination_longitude
    )
  end

end