# typed: true

module Types
    class WorkoutExerciseType < Types::BaseObject
        extend T::Sig

        field :completed, GraphQL::Types::Boolean, null: false
        field :performance_data, PerformanceDataType, null: false, description: "Performance data for the exercise"
        field :exercise, ExerciseType, null: false, description: "Exercise"
        field :order, Integer, null: false, description: "Order of the exercise in the workout"
        field :exercise_history_id, Integer, null: false, description: "Exercise history ID"

        sig { returns(Exercise) }
        def exercise
            Exercise.find(object[:exercise_id])
        end
    end
end