# frozen_string_literal: true

# Pet serializer
class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :tag
end
