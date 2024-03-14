# typed: strict
module Types
    class UserType < Types::BaseObject
      field :id, Integer, null: false, description: "The unique identifier of the user."
      field :name, String, null: true, description: "The name of the user."
      field :email, String, null: true, description: "The email address of the user."
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: "The date and time when the user was created."
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false, description: "The date and time when the user's information was last updated."
  
      # Note: `password_digest` is intentionally omitted to prevent exposing it through the API
    end
  end
  