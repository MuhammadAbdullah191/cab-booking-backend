class Api::V1::ReviewsController < ApplicationController

  def create
    @review = Review.new(feedback: review_params[:feedback], rating: review_params[:rating], booking_id: review_params[:booking_id])

    if @review.save
      render json: { message: 'Review Added Successfilly', review: @review }, status: :ok
    else
      render json: { message: @review.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.permit(:booking_id, :feedback, :rating)
  end
end
