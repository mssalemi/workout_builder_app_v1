module Types
    class WorkoutExerciseType < Types::BaseObject
        field :completed, Boolean, null: false
        field :performance_data, PerformanceDataType, null: false, description: "Performance data for the exercise"
        field :exercise, ExerciseType, null: false, description: "Exercise"

        def exercise
            Exercise.find(object[:exercise_id])
        end
    end
end