class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.string :title
      t.json :goal
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
