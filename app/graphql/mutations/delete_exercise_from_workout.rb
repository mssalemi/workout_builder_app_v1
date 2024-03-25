# typed: strict

module Mutations
    class DeleteExerciseFromWorkout < BaseMutation
      extend T::Sig
  
      description "Delete an exercise from a workout"
  
      argument :exercise_history_id, Integer, required: true, description: "The ID of the exercise history to be deleted."
  
      field :success, GraphQL::Types::Boolean, null: false, description: "Whether the exercise was successfully deleted."
      field :errors, [String], null: false, description: "List of errors encountered during the deletion."
  
      sig { params(exercise_history_id: Integer).returns(T::Hash[T.untyped, T.untyped]) }
      def resolve(exercise_history_id:)
        exercise_history = ExerciseHistory.find_by(id: exercise_history_id)
  
        unless exercise_history
          return {
            success: false,
            errors: ["User or ExerciseHistory not found."]
          }
        end
  
        begin
          exercise_history.destroy!
          {
            success: true,
            errors: [],
          }
        rescue => e
          {
            success: false,
            errors: [e.message],
          }
        end
      end
    end
end