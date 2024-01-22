# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Mutations::AddExerciseToWorkout`.
# Please instead update this file by running `bin/tapioca dsl Mutations::AddExerciseToWorkout`.

class Mutations::AddExerciseToWorkout
  sig do
    params(
      workout_id: ::String,
      exercise_id: ::String,
      performance_data: ::Types::PerformanceDataInputType
    ).returns(T.untyped)
  end
  def resolve(workout_id:, exercise_id:, performance_data:); end
end