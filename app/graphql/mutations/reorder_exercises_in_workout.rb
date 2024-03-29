# typed: strict

module Mutations
    class ReorderExercisesInWorkout < BaseMutation
      extend T::Sig

      description "Reorder exercises in a workout"
  
      # Define the arguments this mutation accepts
      argument :workout_id, Integer, required: true, description: "The ID of the workout to reorder exercises in."
      argument :reorder_instructions, [Types::ReorderInstructionInputType], required: true, description: "The instructions for reordering the exercises."
  
      type Types::WorkoutType
      
      sig { params(workout_id: Integer, reorder_instructions: [Types::ReorderInstructionInputType]).returns(T::Hash[T.untyped, T.untyped])}
      def resolve(workout_id:, reorder_instructions:)
        workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id.to_i)
        raise GraphQL::ExecutionError, "Workout not found" unless workout
  
        # Convert GraphQL input to Ruby array of hashes
        reorder_instructions = reorder_instructions.map(&:to_h)
  
        workout.reorder_exercises(reorder_instructions)
  
        workout.graphql_data
      end
    end
end
  