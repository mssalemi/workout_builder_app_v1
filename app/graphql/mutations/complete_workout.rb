# typed: true

module Mutations
    class CompleteWorkout < BaseMutation
      extend T::Sig

      description "Complete all exercises in a workout"
  
      argument :workout_id, Integer, required: true, description: "The ID of the workout to be completed."
  
      type Types::WorkoutType
  
      sig { params(workout_id: Integer).returns(T::Hash[T.untyped, T.untyped]) }
      def resolve(workout_id:)
        workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id.to_i)
        raise GraphQL::ExecutionError, "Workout not found" unless workout
  
        status = workout.complete_workout
        raise GraphQL::ExecutionError, "Failed to complete workout" unless status
  
        workout.graphql_data
      end
    end
end
  