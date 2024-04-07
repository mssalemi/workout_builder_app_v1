class DropWorkoutWeeksTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :workout_weeks
  end

  def down
    create_table :workout_weeks do |t|
      t.integer :week_number
      t.references :workout_program, null: false, foreign_key: true
      t.timestamps
    end
  end
end
