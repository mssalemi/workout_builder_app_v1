# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject

    field :create_user_workout, mutation: Mutations::CreateUserWorkout

    field :add_exercise_to_workout, Types::WorkoutType, null: false do
      description "Add an exercise to a workout"
      argument :workout_id, ID, required: true
      argument :exercise_id, ID, required: true
      argument :performance_data, Types::PerformanceDataInputType, required: true
    end

    def add_exercise_to_workout(workout_id:, exercise_id:, performance_data:)
      # raise "not allowed right now"
      workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id.to_i)
      raise GraphQL::ExecutionError, "Workout not found" unless workout

      exercise = workout.add_exercise(exercise_id: exercise_id.to_i, performance_data: performance_data.to_h)
      raise GraphQL::ExecutionError, "Failed to add exercise" unless exercise

      workout.graphql_data
    end

    field :update_exercise_in_workout, Types::WorkoutExerciseType, null: false do
      description "Update an exercise's order or performance data in a workout"
      argument :exercise_history_id, ID, required: true
      argument :new_order, Integer, required: false
      argument :new_performance_data, Types::PerformanceDataInputType, required: false
    end
    def update_exercise_in_workout(exercise_history_id:, new_order: nil, new_performance_data: nil)
      exercise = WorkoutBuilder::WorkoutBuilderExercise.load_from_db(exercise_history_id: exercise_history_id.to_i)
      raise GraphQL::ExecutionError, "Exercise not found" unless exercise

      # Convert GraphQL input type to Ruby hash if new_performance_data is provided
      new_performance_data = new_performance_data.to_h if new_performance_data

      exercise.edit_exercise(new_order: new_order, new_performance_data: new_performance_data)


      exercise.graphql_data
    end

    field :reorder_exercises_in_workout, Types::WorkoutType, null: false do
      description "Reorder exercises in a workout"
      argument :workout_id, ID, required: true
      argument :reorder_instructions, [Types::ReorderInstructionInputType], required: true
    end
    def reorder_exercises_in_workout(workout_id:, reorder_instructions:)
      workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id.to_i)
      raise GraphQL::ExecutionError, "Workout not found" unless workout

      # Convert GraphQL input to Ruby array of hashes
      reorder_instructions = reorder_instructions.map(&:to_h)

      workout.reorder_exercises(reorder_instructions)

      workout.graphql_data
    end

    field :complete_workout, Types::WorkoutType, null: false do
      description "Complete all exercises in a workout"
      argument :workout_id, ID, required: true
    end
    def complete_workout(workout_id:)
      workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id.to_i)
      raise GraphQL::ExecutionError, "Workout not found" unless workout

      status = workout.complete_workout
      raise GraphQL::ExecutionError, "Failed to complete workout" unless status

      workout.graphql_data
    end
  end
end
