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

  def show
    pet = Pet.find(params[:id])
    render json: pet, status: :ok
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :tag)
  end

  def error_missing_params
    errors = ['param is missing or the value is empty']
    render json: { errors: errors }, status: :unprocessable_entity
  end
end
