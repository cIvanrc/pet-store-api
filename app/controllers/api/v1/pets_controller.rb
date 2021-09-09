# frozen_string_literal: true

# Handles the #index, #show, #create
class Api::V1::PetsController < ApplicationController
  def index
    render json: Pet.all, status: :ok
  end
end
