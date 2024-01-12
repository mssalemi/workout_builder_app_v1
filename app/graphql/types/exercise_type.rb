# frozen_string_literal: true

module Types
  class ExerciseType < Types::BaseObject
    field :id, Integer, null: false
    field :title, String
    field :description, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
