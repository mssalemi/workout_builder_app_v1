# typed: false
class CreateExerciseHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true
      t.date :date
      t.json :performance_data

      t.timestamps
    end
  end
end
