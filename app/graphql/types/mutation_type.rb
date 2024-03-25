# typed: strict
# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_workout_program, mutation: Mutations::CreateWorkoutProgram

    field :create_user_workout, mutation: Mutations::CreateUserWorkout
    field :add_exercise_to_workout, mutation: Mutations::AddExerciseToWorkout
    field :update_exercise_in_workout, mutation: Mutations::UpdateExerciseInWorkout
    field :reorder_exercises_in_workout, mutation: Mutations::ReorderExercisesInWorkout
    field :complete_workout, mutation: Mutations::CompleteWorkout
    field :delete_exercise_from_workout, mutation: Mutations::DeleteExerciseFromWorkout

    field :user_login, mutation: Mutations::UserLogin
  end
end
