# frozen_string_literal: true

# Handles the #index, #show, #create
class Api::V1::PetsController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :error_missing_params

  def index
    render json: Pet.all, status: :ok
  end

  def create
    pet = Pet.new(pet_params)

    if pet.save
      render status: :created
    else
      render json: { errors: pet.errors }, status: :unprocessable_entity
    end
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :tag)
  end

  def error_missing_params
    render json: { errors: ['param is missing or the value is empty' ]}, status: :unprocessable_entity
  end
end
