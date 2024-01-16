# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    field :create_user_workout, Types::WorkoutType, null: false do
      description "Create a new workout for a user"
      argument :user_id, Integer, required: true
      argument :title, String, required: false
    end

    def create_user_workout(user_id:, title: nil)
      int_user_id = user_id.to_i
      workout = WorkoutBuilder::WorkoutBuilderWorkout.create_user_workout(user_id: int_user_id, title: title)
      
      workout
    end
  end
end
