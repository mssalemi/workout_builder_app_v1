class AddCompletedToExerciseHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :exercise_histories, :completed, :boolean, default: false
  end
end
