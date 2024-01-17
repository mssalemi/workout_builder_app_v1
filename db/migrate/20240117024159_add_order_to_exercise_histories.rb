class AddOrderToExerciseHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :exercise_histories, :order, :integer, default: 0
  end
end
