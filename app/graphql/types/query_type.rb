# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :exercises, [Types::ExerciseType], null: false,
      description: "An example field added by the generator"
    def exercises
      Exercise.all
    end

    field :find_workout, Types::WorkoutType, null: true do
      description "Find a workout by ID"
      argument :workout_id, GraphQL::Types::ID, required: true
    end
    
    def find_workout(workout_id:)
      workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id.to_i)

      return nil unless workout  

      workout.graphql_data
    end
  end
end
