class Api::V1::CarsController < ApplicationController
	before_action :set_car, only: %i(update destroy)

	def index
		@cars = Car.all
		render json: { message: 'Cars loaded successfully', cars: @cars }, status: :ok
	end

	def create
		@car = Car.new(car_params)
		if @car.save
			render json: { message: 'Car created successfully', car: @car }, status: :ok
		else
			render json: { message: @car.errors.full_messages.to_sentence }, status: :unprocessable_entity
		end
	end
	
	def update
		if @car.update(car_params)
      render json: { user: CarSerializer.new(@car), message: 'User updated successfully' }, status: :ok
    else
      render json: { message: @car.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
	end

	private

	def set_car
		@car = set_instance(car_params[:id], Car, '')
	end

	def car_params
		params.permit(:id, :reg_number, :make, :model, :seats, :user_id)
	end
end
