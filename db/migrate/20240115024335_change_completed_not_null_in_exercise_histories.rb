# typed: false
class ChangeCompletedNotNullInExerciseHistories < ActiveRecord::Migration[7.1]
  def change
    change_column_null :exercise_histories, :completed, false
  end
end
