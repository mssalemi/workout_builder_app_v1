module Types
    class WorkoutExerciseType < Types::BaseObject
        field :completed, Boolean, null: false
        field :performance_data, PerformanceDataType, null: false, description: "Performance data for the exercise"
        field :exercise, ExerciseType, null: false, description: "Exercise"
        field :order, Integer, null: false, description: "Order of the exercise in the workout"

        def exercise
            Exercise.find(object[:exercise_id])
        end
    end
end