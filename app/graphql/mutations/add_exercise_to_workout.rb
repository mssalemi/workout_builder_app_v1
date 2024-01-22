# typed: true

module Mutations
    class AddExerciseToWorkout < BaseMutation
      extend T::Sig

      description "Add an exercise to a workout"
  
      argument :workout_id, Integer, required: true, description: "The ID of the workout to which the exercise will be added."
      argument :exercise_id, Integer, required: true, description: "The ID of the exercise to add to the workout."
      argument :performance_data, Types::PerformanceDataInputType, required: true, description: "The performance data for the exercise being added."
  
      type Types::WorkoutType
      
      sig { params(workout_id: Integer, exercise_id: Integer, performance_data: Types::PerformanceDataInputType).returns(Types::WorkoutType) }
      def resolve(workout_id:, exercise_id:, performance_data:)
        workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id.to_i)
        raise GraphQL::ExecutionError, "Workout not found" unless workout
  
        workout.add_exercise(exercise_id: exercise_id.to_i, performance_data: performance_data.to_h)
  
        workout.graphql_data
      end
    end
end
  