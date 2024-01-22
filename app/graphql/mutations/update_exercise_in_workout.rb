# typed: true

module Mutations
    class UpdateExerciseInWorkout < BaseMutation
      extend T::Sig

      description "Update an exercise's order or performance data in a workout"
  
      argument :exercise_history_id, Integer, required: true, description: "The ID of the exercise history record to update."
      argument :new_order, Integer, required: false, description: "The new order for the exercise within the workout."
      argument :new_performance_data, Types::PerformanceDataInputType, required: false, description: "New performance data for the exercise."
  
      type Types::WorkoutExerciseType
      
      sig { params(exercise_history_id: Integer, new_order: T.nilable(Integer), new_performance_data: T.nilable(Types::PerformanceDataInputType)).returns(Types::WorkoutExerciseType) }
      def resolve(exercise_history_id:, new_order: nil, new_performance_data: nil)
        exercise = WorkoutBuilder::WorkoutBuilderExercise.load_from_db(exercise_history_id: exercise_history_id.to_i)
        raise GraphQL::ExecutionError, "Exercise not found" unless exercise
  
        new_performance_data = new_performance_data.to_h if new_performance_data
  
        exercise.edit_exercise(new_order: new_order, new_performance_data: new_performance_data)
  
        exercise.graphql_data
      end
    end
end
  