class Api::V1::LocationsController < ApplicationController
  before_action :set_car

  def create
    location = @car.location || @car.build_location

    if location.update(location_params)
      render json: { message: 'Car location updated successfully', location: location }, status: :ok
    else
      render json: { message: location.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def set_car
    @car = set_instance(location_params[:car_id], Car, '')
  end

  def location_params
    params.permit(:car_id, :latitude, :longitude)
  end

end
