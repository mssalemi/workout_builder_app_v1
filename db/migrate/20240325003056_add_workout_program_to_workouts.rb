class AddWorkoutProgramToWorkouts < ActiveRecord::Migration[7.1]
  def change
    add_reference :workouts, :workout_program, foreign_key: true, index: true
  end
end
