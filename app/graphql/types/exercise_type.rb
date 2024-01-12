module Types
  class ExerciseType < Types::BaseObject
    field :id, Integer, null: false
    field :title, String
    field :description, String
    field :user_id, Integer, null: true  # User ID can be nil
    field :category, String
    field :body_part_main, String, null: false  # Required field
    field :body_part_accessory, Types::ArrayStringType, null: true  # Custom JSONB scalar type
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end