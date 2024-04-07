# typed: strict

module Mutations
    class AddExerciseToWorkout < BaseMutation
      extend T::Sig

      description "Add an exercise to a workout"
  
      argument :workout_id, Integer, required: true, description: "The ID of the workout to which the exercise will be added."
      argument :exercise_id, Integer, required: true, description: "The ID of the exercise to add to the workout."
      argument :performance_data, Types::PerformanceDataInputType, required: true, description: "The performance data for the exercise being added."
      argument :user_id, Integer, required: false, description: "The ID of the user performing the exercise."

      type Types::WorkoutType
      
      sig { params(workout_id: Integer, exercise_id: Integer, performance_data: Types::PerformanceDataInputType, user_id: T.nilable(Integer)).returns(T::Hash[T.untyped, T.untyped]) }
      def resolve(workout_id:, exercise_id:, performance_data:, user_id: nil)
        current_user = context[:current_user]

        workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id.to_i)
        raise GraphQL::ExecutionError, "Workout not found" unless workout

        if (workout.user.id != current_user.id)
          raise GraphQL::ExecutionError, "You are not authorized to add an exercise to this workout."
        end

        workout.add_exercise(exercise_id: exercise_id.to_i, performance_data: performance_data.to_h, user_id: user_id || current_user.id)
  
        workout.graphql_data
      end
    end
end
  