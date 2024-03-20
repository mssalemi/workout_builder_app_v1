# typed: false
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

    field :find_workouts_by_user, [Types::WorkoutType], null: false do
      description "Find all workouts by User ID sent through JWT token."
    end

    def find_workouts_by_user
      puts "GOT HERE"
      current_user = context[:current_user]
      puts "CURRENT USER: ", current_user
      puts "CURRENT USER ID: ", current_user.id
      puts "----------------------------"
      puts "----------------------------"
      puts "----------------------------"
      puts "----------------------------"
      # Fetch the last 10 workouts by ID for the given user, assuming higher IDs are more recent.
      workouts = Workout.where(user_id: current_user.id).order(id: :desc).limit(10)
      puts "workouts", workouts
      # Load and map each workout using your existing logic
      workouts.map do |workout|
        WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout.id)
      end.map(&:graphql_data) # Ensure your Workout model or builder has a method `graphql_data` to format the data for GraphQL response
    end
  end
  
end
