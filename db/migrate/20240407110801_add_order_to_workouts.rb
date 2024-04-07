class AddOrderToWorkouts < ActiveRecord::Migration[7.1]
  def change
    add_column :workouts, :order, :integer
  end
end
