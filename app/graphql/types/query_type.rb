# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :exercises, [Types::ExerciseType], null: false,
      description: "An example field added by the generator"
    def exercises
      Exercise.all
    end

    field :find_workout, Types::WorkoutType, null: true do
      description "Find a workout by ID"
      argument :workout_id, GraphQL::Types::ID, required: true
    end

    def find_workout(workout_id:)
      workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id.to_i)

      return nil unless workout  

      exercises = workout.exercises.map do |exercise|
        {
          exercise_id: exercise.exercise_id,
          completed: exercise.completed,
          performance_data: exercise.goal,
          order: exercise.order,
          exercise_history_id: exercise.exercise_history.id
        }
      end

      {
        id: workout.workout_id,
        title: workout.title,
        user_id: workout.user.id,
        exercises: exercises
      }
    end
  end
end
