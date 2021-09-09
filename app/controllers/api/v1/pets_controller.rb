# frozen_string_literal: true

# Handles the #index, #show, #create
class Api::V1::PetsController < ApplicationController
  def index
    @pets = Pet.page(page).per(limit)
    set_pagination_headers
    render json: @pets, status: :ok
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

  def page
    params[:page] || 1
  end

  def limit
    limit_param = (params[:limit] || 5).to_i
    limit_param >= 100 ? 100 : limit_param
  end

  def set_pagination_headers
    headers['Link'] = next_link(@pets.next_page) if @pets.next_page
  end

  def next_link(page)
    "<#{api_v1_pets_url(request.query_parameters.merge(page: page))}; rel='next'>"
  end
end
