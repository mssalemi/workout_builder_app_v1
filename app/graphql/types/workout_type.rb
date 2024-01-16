# frozen_string_literal: true

module Types
  class WorkoutType < Types::BaseObject
    field :id, Integer, null: false
    field :title, String, null: true
    field :user_id, Integer, null: false
  end
end
