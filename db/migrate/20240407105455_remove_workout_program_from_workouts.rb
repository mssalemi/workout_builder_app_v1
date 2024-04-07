class RemoveWorkoutProgramFromWorkouts < ActiveRecord::Migration[7.1]
  def change
    remove_reference :workouts, :workout_program, index: true, foreign_key: true
  end
end
