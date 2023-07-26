class Api::V1::BookingsController < ApplicationController
  before_action :set_booking

  def create
    set_booking_locations
  end

  private

  def set_booking
    @booking = Booking.new(car_id: params[:car_id], user_id: params[:user_id])
    if !@booking.save
      render json: { message: @booking.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def set_booking_locations
    begin
      if(!params[:pickup] || !params[:dropoff])
        raise StandardError.new, 'Pickup and Dropoff Location cannot be null'
      end
      @booking.locations.create!(status: 'pickup', latitude: params[:pickup][:latitude], longitude: params[:pickup][:longitude])
      @booking.locations.create!(status: 'dropoff', latitude: params[:dropoff][:latitude], longitude: params[:dropoff][:longitude])
      render json: { message: 'Car Booking created successfully', booking: @booking }, status: :ok
    rescue StandardError => e
      render json: { message: e }, status: :unprocessable_entity
      return
    end
  end
end
