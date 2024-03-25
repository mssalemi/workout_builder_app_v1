class CreateWorkoutPrograms < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_programs do |t|
      t.string :title, null: false
      t.text :description
      t.integer :user_id, null: false
      t.string :difficulty_level
      t.integer :duration_weeks
      t.timestamps
    end

    add_index :workout_programs, :user_id, name: 'index_workout_programs_on_user_id'
    add_foreign_key :workout_programs, :users
  end
end
