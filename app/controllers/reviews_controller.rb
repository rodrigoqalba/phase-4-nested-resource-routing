class ReviewsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:dog_house_id]
      dog_house = find_dog_house
      reviews = dog_house.reviews
    else
      reviews = Review.all
    end
    render json: reviews, include: :dog_house
  end

  def show
    review = find_review
    render json: review, include: :dog_house
  end

  def create
    review = Review.create(review_params)
    render json: review, status: :created
  end

  private

  def render_not_found_response
    render json: { error: "Review not found" }, status: :not_found
  end

  def review_params
    params.permit(:username, :comment, :rating)
  end

  def find_review
    Review.find(params[:id])
  end

  def find_dog_house
    DogHouse.find(params[:dog_house_id])
  end
  
  

end
